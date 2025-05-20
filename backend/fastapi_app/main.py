import json
from time import sleep
from fastapi import FastAPI, HTTPException, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from .gpt_service import generate_sentence
from .websocket import ws_manager
from .message_handler import save_message_to_django

app = FastAPI()

# CORS 설정 추가
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 개발
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.post("/generate-sentence")
async def generate_sentence_api():
    try:
        sentence = await generate_sentence()
        # sleep(5)
        return {"sentence": sentence}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.websocket("/ws/chat/{chat_id}")
async def websocket_handler(websocket: WebSocket, chat_id: int):

    # 새 요청(chat) active_connections에 등록
    await ws_manager.connect(websocket, chat_id)

    # 연결(conn)이 종료될 때 까지 계속해서 client로부터 새로운 메세지를 읽음
    try:
        while True:
            data = await websocket.receive_text()

            data = json.loads(data)
            message = data["message"]
            user_id = data["user_id"]
            saved = await save_message_to_django(message, chat_id, user_id)
            # print(saved)

            # 연결된 모든 클라이언트에게 메시지 전송
            for ws in ws_manager.active_connections.get(chat_id, []):
                try:
                    if ws != websocket:  # 메시지를 보낸 클라이언트 제외
                        await ws.send_text(json.dumps(saved))
                except Exception as e:
                    print(f"Error sending message: {e}")
                    continue

    except WebSocketDisconnect:
        ws_manager.disconnect(websocket, chat_id)
        print(f"disconnected: {chat_id}")
