from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import NoteViewSet

router = DefaultRouter()
router.register(r"", NoteViewSet)  # 기본 경로에 NoteViewSet 등록

urlpatterns = [
    path("", include(router.urls)),
]
