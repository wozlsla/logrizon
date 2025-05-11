from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    first_name = models.CharField(max_length=150, editable=False)
    last_name = models.CharField(max_length=150, editable=False)
    name = models.CharField(max_length=150, default="")
    avatar = models.URLField(blank=True, null=True)
    # name(닉네임) / username(id)??Required / email -> 필수로 수정할 것 (first/last 제거)

    def __str__(self) -> str:
        return self.name
