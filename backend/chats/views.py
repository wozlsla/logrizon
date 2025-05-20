from rest_framework.exceptions import NotFound, NotAuthenticated, ParseError
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.db import transaction

from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import status
from .models import Chat, Message
from .serializers import ChatListSerializer, ChatDetailSerializer, MessageSerializer
from users.models import User


class Chats(APIView):

    def get(self, request):
        chats = Chat.objects.all()
        serializer = ChatListSerializer(chats, many=True)
        return Response(serializer.data)

    def post(self, request):
        # user 검증
        if request.user.is_authenticated:
            serializer = ChatListSerializer(data=request.data)
            if serializer.is_valid():
                try:
                    with transaction.atomic():
                        # create / update (db)
                        chat = serializer.save(owner=request.user)
                        serializer = ChatListSerializer(chat)
                        return Response(serializer.data)
                except Exception as e:
                    raise ParseError("채팅방 생성 중 오류가 발생했습니다: " + str(e))
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        else:
            raise NotAuthenticated


class ChatDetail(APIView):
    def get_object(self, chat_id):
        try:
            return Chat.objects.get(pk=chat_id)
        except Chat.DoesNotExist:
            raise NotFound

    def get(self, request, chat_id):
        chat = self.get_object(chat_id)
        serializer = ChatDetailSerializer(chat)
        return Response(serializer.data)

    def put(self, request, chat_id):
        chat = self.get_object(chat_id)
        serializer = ChatDetailSerializer(chat, data=request.data)
        if serializer.is_valid():
            updated_chat = serializer.save()
            return Response(ChatDetailSerializer(updated_chat).data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, chat_id):
        chat = self.get_object(chat_id)
        chat.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class Messages(APIView):  # <int:chat_id>/messages
    permission_classes = [AllowAny]  # 임시로 인증 비활성화

    def get_object(self, chat_id):
        try:
            return Chat.objects.get(pk=chat_id)
        except Chat.DoesNotExist:
            raise NotFound("Chat not found.")

    def get(self, request, chat_id):
        chat = self.get_object(chat_id)
        messages = chat.messages.all().order_by("created_at")
        serializer = MessageSerializer(messages, many=True)
        return Response(serializer.data)

    def post(self, request, chat_id):
        chat = self.get_object(chat_id)
        print("Received data:", request.data)  # 디버깅을 위해 추가
        serializer = MessageSerializer(data=request.data)
        if serializer.is_valid():
            # serializer.save(chat=chat, user=request.user)  # chat을 넘겨줌

            # 인증 없이 웹소켓 테스트) 임시로 첫 번째 사용자를 사용
            user = User.objects.first()
            if not user:
                raise ParseError("사용자가 없습니다.")
            saved_message = serializer.save(chat=chat, user=user)

            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class MessageDetail(APIView):  # <int:chat_id>/messages/<int:message_id>
    def get_object(self, chat_id, message_id):
        try:
            message = Message.objects.get(pk=message_id, chat__pk=chat_id)
            return message
        except Message.DoesNotExist:
            raise NotFound("Message not found.")

    def get(self, request, chat_id, message_id):  # 왜 필요? 답글, 세부 데이터(파일 등)
        message = self.get_object(chat_id, message_id)
        serializer = MessageSerializer(message)
        return Response(serializer.data)

    def put(self, request, chat_id, message_id):
        message = self.get_object(chat_id, message_id)

        if message.user != request.user:
            return Response({"detail": "수정 권한이 없습니다."}, status=403)

        serializer = MessageSerializer(message, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
            # updated = serializer.save()
            # return Response(MessageSerializer(updated).data)
        return Response(serializer.error, status=400)

    def delete(self, request, chat_id, message_id):
        message = self.get_object(chat_id, message_id)
        message.soft_delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
