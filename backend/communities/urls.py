from django.urls import path
from .views import Communities, CommunityDetail

urlpatterns = [
    path("", Communities.as_view()),
    path("<int:community_id>", CommunityDetail.as_view()),
]
