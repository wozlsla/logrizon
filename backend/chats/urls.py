from django.urls import path
from . import views

urlpatterns = [
    path("", views.Chats.as_view(), name="chat-list"),
    path("<int:chat_id>", views.ChatDetail.as_view(), name="chat-detail"),
    path("<int:chat_id>/messages", views.Messages.as_view(), name="message-list"),
    path(
        "<int:chat_id>/messages/<int:message_id>",
        views.MessageDetail.as_view(),
        name="message-detail",
    ),
]
