from django.contrib import admin
from .models import Note


@admin.register(Note)
class NoteAdmin(admin.ModelAdmin):

    list_display = ("contents", "user")

    search_fields = ("^user",)
