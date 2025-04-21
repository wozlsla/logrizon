# Logrizon

```
.
├── backend/           # Django
│   ├── Dockerfile
│   └── ...
├── frontend/          # Flutter
│   ├── build/web      # Flutter Web (deploy)
│   ├── Dockerfile
│   └── ...
├── nginx/
├── docker-compose.yml
├── .github/            # GitHub Action
└── README.md
```

<br/>
<br/>

## Frontend (Flutter)

```
.
├── main.dart
├── common
├── providers
├── route
└── views
    ├── entrypoint
    ├── home
    └── note

```

<br/>

## Backend

### Apps

- Users
- Notes  
  ...
  <br/>

### API

| Endpoint  | 상태    | 설명                                             |
| --------- | ------- | ------------------------------------------------ |
| `/users/` | 개발 중 | 사용자 인증/정보 관련 API 예정                   |
| `/notes/` | 테스트  | Flutter에서 노트 등록/조회 기능 연동 테스트 완료 |

<br/>

```http
GET /api/v1/notes/
POST /api/v1/notes/
```

<br/>
