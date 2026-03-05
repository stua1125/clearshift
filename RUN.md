# ClearShift 실행 가이드

## 1. 앱 실행 방법

### iOS 시뮬레이터
```bash
open -a Simulator
flutter run
```

### macOS 데스크톱
```bash
flutter run -d macos
```

### Chrome 웹
```bash
flutter run -d chrome
```

### 사용 가능한 디바이스 확인
```bash
flutter devices
```

## 2. 화면별 접근

현재 초기 화면: `/worker/calendar` (Worker 캘린더)

### 초기 화면 변경 방법

`lib/core/router/app_router.dart`의 `initialLocation` 값을 변경:

```dart
final appRouter = GoRouter(
  initialLocation: '/worker/calendar',  // ← 여기를 변경
  ...
);
```

### 사용 가능한 라우트

| 라우트 | 화면 | 역할 |
|--------|------|------|
| `/worker/calendar` | Worker 월별 캘린더 (Paint Mode) | 근무자 |
| `/manager/calendar` | 매니저 월별 캘린더 (팀원 현황) | 매니저 |
| `/manager/shift-types` | 근무타입 CRUD | 매니저 |
| `/manager/vacation-settings` | 휴가 MAX 관리 | 매니저 |
| `/manager/events` | 이벤트 관리 | 매니저 |
| `/manager/team/:memberId/schedule?name=이름` | 팀원 스케줄 상세 | 매니저 |

## 3. Paint Mode 사용법

1. **Paint ON** 버튼 탭 → Paint Mode 활성화
2. 근무 타입 선택 (주간/야간/휴무/휴가/교육)
3. 캘린더 날짜 탭 → 해당 날짜에 근무타입 배정
4. 같은 날짜 다시 탭 → 배정 해제 (토글)
5. **지우기** 선택 후 탭 → 기존 배정 삭제
6. 모든 날짜 배정 완료 (100%) → **제출하기** 버튼 활성화

## 4. 백엔드 실행

### PostgreSQL (Docker)
```bash
cd backend
docker compose up db -d
```

### Spring Boot 실행
```bash
cd backend
./gradlew bootRun
```

### API 확인
```bash
# 지점 목록
curl http://localhost:8080/api/branches

# 헬스체크
curl http://localhost:8080/actuator/health
```

### 전체 Docker 실행
```bash
cd backend
docker compose up --build
```

### 포트
- PostgreSQL: `5433` (로컬 5432 충돌 방지)
- Spring Boot API: `8080`
