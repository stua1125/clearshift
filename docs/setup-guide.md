# ClearShift 서버 실행 가이드

## 사전 요구사항

| 도구 | 버전 |
|------|------|
| Java | 21+ |
| Flutter | 3.x (Dart SDK ^3.11.0) |
| Docker & Docker Compose | 최신 |

## 1. 백엔드 (Spring Boot + PostgreSQL)

### Docker Compose로 실행 (권장)

```bash
cd backend
docker compose up -d
```

- PostgreSQL: `localhost:5433`
- API 서버: `localhost:8080`
- Swagger UI: http://localhost:8080/swagger-ui/index.html

### 로컬에서 직접 실행

#### 1) DB만 Docker로 띄우기

```bash
cd backend
docker compose up -d db
```

#### 2) Spring Boot 실행

```bash
cd backend
./gradlew bootRun --args='--spring.profiles.active=dev'
```

`dev` 프로파일 사용 시 Flyway가 비활성화되고 JPA `ddl-auto=update`로 동작합니다.

### 개발용 인증 토큰

dev 프로파일에서는 Google OAuth 없이 테스트 토큰을 발급받을 수 있습니다:

```bash
curl -X POST http://localhost:8080/api/dev/token \
  -H "Content-Type: application/json" \
  -d '{"email": "test@example.com", "name": "테스트유저"}'
```

### DB 초기 데이터

Flyway 마이그레이션(`V1__init.sql`)이 자동으로 적용됩니다:
- 기본 지점: 삼성 강북점 (`samsung-gangbuk`)
- 기본 근무타입: 주간(D), 야간(N), 휴무(OFF), 휴가(V), 교육(T)
- 기본 휴가 제한: 일 최대 3명

### 환경변수 (선택)

| 변수 | 설명 | 기본값 |
|------|------|--------|
| `GOOGLE_CLIENT_ID` | Google OAuth Client ID | placeholder |
| `JWT_SECRET` | JWT 서명 키 (256bit 이상) | 개발용 기본값 제공 |

---

## 2. 프론트엔드 (Flutter)

### 의존성 설치

```bash
flutter pub get
```

### 코드 생성 (Freezed, Riverpod)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 실행

```bash
# iOS 시뮬레이터
flutter run

# Chrome (웹)
flutter run -d chrome

# 특정 디바이스
flutter devices
flutter run -d <device-id>
```

---

## 3. 전체 스택 한 번에 실행

```bash
# 터미널 1: 백엔드
cd backend && docker compose up -d

# 터미널 2: 프론트엔드
flutter run
```

API 기본 주소: `http://localhost:8080`
