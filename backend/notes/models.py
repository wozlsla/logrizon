from django.db import models


class Note(models.Model):
    """Model Definition for Notes"""

    title = models.CharField(max_length=150)
    contents = models.TextField()
    user = models.ForeignKey("users.User", on_delete=models.SET_NULL, null=True)

    def __str__(self):
        return self.title
