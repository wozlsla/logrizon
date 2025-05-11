from django.db import models
from common.models import CommonModel


class Community(CommonModel):
    """Community Model Definition"""

    class CommunityKindChoices(models.TextChoices):
        PRIVATE = ("private", "Private")
        PUBLIC = ("public", "Public")

    name = models.CharField(max_length=40)
    description = models.TextField(blank=True)
    kind = models.CharField(
        max_length=20,
        choices=CommunityKindChoices.choices,
        default=CommunityKindChoices.PRIVATE,
    )
    owner = models.ForeignKey(
        "users.User",
        on_delete=models.SET_NULL,
        null=True,
        related_name="owned_communities",
    )
    members = models.ManyToManyField(
        "users.User",
        related_name="joined_communities",
        blank=True,
    )

    def __str__(self) -> str:
        return self.name

    class Meta:
        verbose_name_plural = "Communities"
