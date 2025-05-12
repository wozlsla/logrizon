# Logrizon

기록을 기반으로 사용자의 자발적 참여와 성장을 유도하는 앱 개발

- 개인 기록(메모, 일기, 학습 내역, 아이디어 등)을 단순 저장하는 것을 넘어, 게임 시스템의 성장 구조(퀘스트, 레이드, 점수화 시스템 등)를 차용하여 사용자가 `자발적으로 참여`하고 즐길 수 있도록 기획.
- 기록을 모아 AI 도구를 활용하여 `생각을 확장`하고, 성취감을 기반으로 지속적 사용을 유도하는 동기부여 시스템 구축.

<br/>

```
.
├── backend/           # Django
│   ├── Dockerfile
│   ├── fastapi_app/   # FastAPI : LLM serviece & chats
│   └── ...
├── frontend/          # Flutter
│   ├── build/web      # Flutter Web (deploy)
│   ├── Dockerfile
│   └── ...
├── nginx/
├── docker-compose.yml
├── .github/           # GitHub Action (CI/CD)
└── README.md
```

<br/>
<br/>

## Frontend (Flutter)

```
.
├── main.dart
├── common
├── config
│   ├── api.dart
│   └── env_config.dart
├── core
│   ├── router
│   └── theme
├── providers
└── views
    ├── entrypoint
    ├── home
    ├── note
    └── profile

```

<br/>

### UX/UI

**글 작성 (Note)**

- Note 탭 : 글 작성
- Daily 탭 : GPT 문장 생성 버튼 [GET]
  - Flutter <-> FastAPI(GPT 통신) -> Django

<br/>

## Backend (Django + FastAPI)

```
.
├── manage.py
├── config
├── fastapi_app/  # llm
...
├── users
├── chats
├── communities (group)
└── notes
```

<br/>

### Apps

- Users
- Notes
- Chats
- Communities
- Task  
   ...  
  <br/>
  <br/>

### API

| Endpoint                            | 상태       | 설명                           |
| ----------------------------------- | ---------- | ------------------------------ |
| `/api/v1/users/`                    | Todo       | 사용자 인증/정보 관련 API 예정 |
| `/api/v1/notes/`                    | Done       | 글 등록/조회 기능: GET, POST   |
| `/api/v1/chats/`                    | Done       | 채팅 기능: DM, GroupChat       |
| `/api/v1/chats/<chat_id>/messages/` | InProgress |                                |
| `/api/v1/communities/`              | InProgress |                                |
| `/generate-sentence`                | Done       | GPT 문장 생성 기능             |

<br/>
<br/>
