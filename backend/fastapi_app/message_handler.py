import httpx

DJANGO_BASE_URL = "http://localhost:8000/api/v1"


async def save_message_to_django(message: str, chat_id: int, user_id: int):
    url = f"{DJANGO_BASE_URL}/chats/{chat_id}/messages"

    data = {
        "text": message,
        "user_id": user_id,
        # "chat_id": chat_id,
    }

    async with httpx.AsyncClient() as client:
        response = await client.post(url, json=data)
        response.raise_for_status()
        return response.json()
