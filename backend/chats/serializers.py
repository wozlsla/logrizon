from httpx import request
from rest_framework.exceptions import ParseError
from rest_framework import serializers

from users.models import User
from .models import Chat, Message
from users.serializers import TinyUserSerializer
from communities.serializers import CommunitySerializer


class ChatListSerializer(serializers.ModelSerializer):

    class Meta:
        model = Chat  # Chat 모델을 사용하여 serializer 생성 (model field 자동 매핑) + create, update 메서드 자동 생성 !!
        fields = (
            "id",
            "chat_type",
            "community",
            "title",
            # "notice",
            # "owner",
            # "users",
        )

    def validate(self, data):
        chat_type = data.get("chat_type", Chat.ChatType.DIRECT)  # default
        community = data.get("community", None)
        users = self.initial_data.get("users", [])
        # request_user = self.context["request"].user # user << owner

        existing_users = User.objects.filter(pk__in=users)
        if len(users) - len(existing_users) > 0:
            raise serializers.ValidationError(
                {"users": "유효하지 않은 유저가 포함되어 있습니다."}
            )

        if chat_type == Chat.ChatType.GROUP:
            if not community:
                raise serializers.ValidationError(
                    {"community": "그룹 채팅방은 community를 지정해야 합니다."}
                )
            if len(existing_users) > 100:
                raise serializers.ValidationError(
                    {"users": "그룹 채팅방은 최대 100명까지 참여할 수 있습니다."}
                )
        elif chat_type == Chat.ChatType.DIRECT:
            if community:
                raise serializers.ValidationError(
                    {"community": "DM은 community를 지정할 수 없습니다."}
                )
            if len(existing_users) != 2:
                raise serializers.ValidationError(
                    {"users": "DM은 유효한 유저 2명을 포함해야 합니다."}
                )

        else:
            raise serializers.ValidationError(
                {"chat_type": "지원하지 않는 채팅 타입입니다."}
            )

        return data

    # def create(self, validated_data):
    #     # print(validated_data)
    #     return  # debug


class MessageSerializer(serializers.ModelSerializer):

    class Meta:
        model = Message
        exclude = (
            "id",
            "created_at",
            "is_deleted",
            "deleted_at",
            "chat",
        )


class ChatDetailSerializer(serializers.ModelSerializer):

    owner = TinyUserSerializer(read_only=True)
    users = TinyUserSerializer(many=True)  # relationship
    messages = MessageSerializer(many=True, read_only=True)  # relationship
    community = CommunitySerializer(read_only=True)  # relationship

    class Meta:
        model = Chat
        # fields = "__all__"
        exclude = ("notice",)
        depth = 1
