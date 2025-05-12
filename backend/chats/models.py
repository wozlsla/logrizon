from django.core.exceptions import ValidationError  # Django
from django.utils import timezone
from django.db import models
from common.models import CommonModel


class Chat(CommonModel):
    """Chat Model Definition"""

    class ChatType(models.TextChoices):
        DIRECT = ("direct", "Direct")
        GROUP = ("group", "Group")

    class MessageType(models.TextChoices):
        TEXT = ("text", "Text")
        IMAGE = ("image", "Image")
        FILE = ("file", "File")

    # Chat fields
    chat_type = models.CharField(
        max_length=10,
        choices=ChatType.choices,
        default=ChatType.DIRECT,
    )
    users = models.ManyToManyField(
        "users.User",
        related_name="chats",
    )
    title = models.CharField(max_length=120, blank=True, null=True)  # 그룹 채팅방 제목
    notice = models.TextField(blank=True, null=True)  # 그룹 채팅방 공지
    owner = models.ForeignKey(
        "users.User",
        null=True,
        on_delete=models.SET_NULL,
        related_name="owned_chats",
    )
    community = models.ForeignKey(
        "communities.Community",
        on_delete=models.CASCADE,
        related_name="chats",
        null=True,
        blank=True,
    )

    def __str__(self):
        if self.chat_type == self.ChatType.DIRECT:
            return f"[DM] #{self.pk}"
        return f"[Group] {self.title}"

    # admin validation
    def clean(self):
        if self.chat_type == self.ChatType.DIRECT:
            if self.community:
                raise ValidationError("DM은 커뮤니티에 속할 수 없습니다.")
        else:  # GROUP
            if not self.community:
                raise ValidationError("그룹 채팅방은 커뮤니티에 속해야 합니다.")
            if not self.title:
                raise ValidationError("그룹 채팅방은 제목이 필요합니다.")


class Participant(CommonModel):
    pass


class Message(CommonModel):
    """Message Model Definition"""

    text = models.TextField()
    user = models.ForeignKey(
        "users.User",
        on_delete=models.SET_NULL,
        null=True,
        related_name="messages",
    )
    chat = models.ForeignKey(
        "chats.Chat",
        on_delete=models.CASCADE,
        related_name="messages",
    )
    message_type = models.CharField(
        max_length=20,
        choices=Chat.MessageType.choices,
        default=Chat.MessageType.TEXT,
    )
    # file_url = models.URLField(blank=True, null=True)
    # is_read = models.BooleanField(default=False)
    # read_by = models.ManyToManyField(
    #     "users.User",
    #     related_name="read_messages",
    #     blank=True,
    # )
    is_deleted = models.BooleanField(default=False)
    deleted_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        chat_type = "DM" if self.chat.chat_type == Chat.ChatType.DIRECT else "Group"
        return f"({chat_type}) {self.user.name}: {self.text[:14]}"

    def soft_delete(self):
        self.is_deleted = True
        self.deleted_at = timezone.now()
        self.save()
