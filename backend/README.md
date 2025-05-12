## Django (Gunicorn)

### Notes

`/api/v1/notes/`

- GET: 노트 목록 조회
- POST: 노트 생성

### Chats

`/api/v1/chats/`

- GET: 채팅 목록 조회
- POST: 채팅 생성

`/api/v1/chats/<chat_id>/`

- GET: 채팅 상세 조회
- PUT: 채팅 수정
- DELETE: 채팅 삭제

### Messages

`/api/v1/chats/<chat_id>/messages/`

- GET: 메시지 목록 조회
- POST: 메시지 생성

`/api/v1/chats/<chat_id>/messages/<message_id>/`

- GET: 메시지 상세 조회
- PUT: 메시지 수정
- DELETE: 메시지 삭제

<br/>

## FastAPI (Uvicorn)

### GPT 문장 생성

`/generate-sentence`

- POST: 문장 생성 요청

### Message 송수신 (websocket)
