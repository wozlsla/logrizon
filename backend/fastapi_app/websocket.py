from fastapi import WebSocket


class WebSocketConnectionManager:
    def __init__(self):
        # chat_id - WebSocket list
        self.active_connections: dict[int, list[WebSocket]] = {}
        # self.active_connections: list[tuple[WebSocket, int]] = []

    async def connect(self, websocket: WebSocket, chat_id: int):

        await websocket.accept()
        print(f"accept: {chat_id}")
        # self.active_connections.append((websocket, chat_id))  # 요청 추가
        self.active_connections.setdefault(chat_id, []).append(websocket)

    def disconnect(self, websocket: WebSocket, chat_id: int):
        # self.active_connections.remove((websocket, chat_id))  # 요청 삭제
        self.active_connections[chat_id].remove(websocket)
        # if not self.active_connections[chat_id]:  # 채팅방 삭제
        #     del self.active_connections[chat_id]

    # async def send_message(self, message: str, chat_id: int):


ws_manager = WebSocketConnectionManager()
