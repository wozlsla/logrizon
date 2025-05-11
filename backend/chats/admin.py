from django.core.exceptions import ValidationError  # Django
from django.contrib import admin
from .models import Chat, Message


@admin.register(Chat)
class ChatAdmin(admin.ModelAdmin):

    list_display = (
        "__str__",
        "chat_type",
        "user_count",
        # "user_names",
        # "latest_message",
        "created_at",
        "updated_at",
    )

    list_filter = ("chat_type",)
    ordering = ("-updated_at",)
    search_fields = ("users__name",)
    readonly_fields = ("created_at", "updated_at")

    def save_model(self, request, obj, form, change):
        try:
            obj.full_clean(exclude=["users"])  # users는 아직 저장되지 X
        except ValidationError as e:
            raise ValidationError(e)
        super().save_model(request, obj, form, change)

    def save_related(self, request, form, formsets, change):
        super().save_related(request, form, formsets, change)
        obj = form.instance

        # 여기서 검사
        if obj.chat_type == "direct":
            if obj.users.count() != 2:
                raise ValidationError("DM은 정확히 2명의 유저만 참여해야 합니다.")
        elif obj.chat_type == "group":
            if obj.users.count() > 100:
                raise ValidationError(
                    "그룹 채팅방은 최대 100명까지 참여할 수 있습니다."
                )

    @admin.display(description="Headcount")
    def user_count(self, obj):
        return obj.users.count()

    # @admin.display(description="User Names")
    # def user_names(self, obj):
    # return ", ".join([user.name for user in obj.users.all()])

    # @admin.display(description="Updated")  # 수정
    # def latest_message(self, obj):
    #     latest = obj.messages.order_by("-created_at").first()
    #     if latest:
    #         return f"{latest.user.name if latest.user else '?'}: {latest.text[:20]}"
    #     return "-"


@admin.register(Message)
class MessageAdmin(admin.ModelAdmin):
    list_display = (
        "text",
        "user",
        "chat",
        "created_at",
        "updated_at",
    )
