from django.db import models


class Note(models.Model):
    """Model Definition for Notes"""

    class NoteKindChoices(models.TextChoices):
        NOTE = ("note", "Note")
        DAILY = ("daily", "Daily")

    # title = models.CharField(max_length=150)
    contents = models.TextField()
    user = models.ForeignKey(
        "users.User",
        on_delete=models.SET_NULL,
        null=True,
    )
    kind = models.CharField(
        max_length=10,
        choices=NoteKindChoices.choices,
        default=NoteKindChoices.NOTE,
    )

    def __str__(self) -> str:
        return self.contents[:20]
