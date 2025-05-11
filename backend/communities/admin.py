from os import name
from django.contrib import admin
from .models import Community


@admin.register(Community)
class CommunityAdmin(admin.ModelAdmin):
    list_display = (
        "name",
        "kind",
        "owner",
        "member_count",
        "created_at",
        "updated_at",
    )

    list_filter = ("kind",)
    search_fields = ("name", "owner__name")

    # @admin.display(description="Head")
    # def owner_name(self, obj):
    #     return obj.owner.name if obj.owner else "None"

    @admin.display(description="Headcount")
    def member_count(self, obj):
        return obj.members.count()
