# ClearShift 유저 플로우 & 정책

## 역할 (Role)

| 역할 | 설명 |
|------|------|
| WORKER | 근무자. 자신의 월별 스케줄을 입력/제출 |
| MANAGER | 매니저. 팀 스케줄 관리, 근무타입/휴가/이벤트 설정 |
| ADMIN | 관리자 (미구현) |

---

## 인증 플로우

```
Google 로그인 → 기존 유저? → JWT 발급 → 홈
                 ↓ (신규)
           회원가입 (이름 + 지점 선택) → JWT 발급 → 홈
```

- Google OAuth ID Token으로 인증
- JWT Access Token (1시간) + Refresh Token (7일) 발급
- dev 프로파일에서는 `/api/dev/token`으로 테스트 토큰 발급 가능

---

## 앱 네비게이션 (3탭)

### 탭 1: 공유 캘린더 (`/shared/calendar`) — 기본 화면

같은 지점(Branch) 소속 팀원의 스케줄을 조회하는 읽기 전용 화면

- **월간 뷰**: 날짜별 근무타입 인원수 요약
- **주간 뷰**: 팀원별 일일 근무 배정 상세
- 날짜 탭 → 해당 일자 상세 바텀시트
- 캘린더 이벤트 표시

### 탭 2: 근무 신청 (`/worker/calendar`)

근무자가 Paint Mode로 자신의 월별 스케줄을 입력하는 화면

- 하단 툴바에서 근무타입(D/N/OFF/V/T) 선택
- 캘린더 날짜를 터치/드래그하여 근무 배정 (Paint Mode)
- 입력 완료 후 "제출" → 매니저에게 전달

### 탭 3: 설정 (`/manager/shift-types`)

매니저용 관리 화면

- **근무타입 관리**: 추가/수정/삭제/순서변경
- **휴가 제한 설정** (`/manager/vacation-settings`): 일별 최대 휴가 인원 설정
- **이벤트 관리** (`/manager/events`): 지점 공유 캘린더 이벤트 CRUD

---

## 스케줄 제출 플로우

```
DRAFT (작성중) → SUBMITTED (제출됨) → APPROVED/REJECTED (승인/반려)
```

| 상태 | 설명 |
|------|------|
| DRAFT | 근무자가 작성 중. 수정 가능 |
| SUBMITTED | 제출 완료. 매니저 검토 대기 |
| APPROVED | 매니저 승인 (미구현) |
| REJECTED | 매니저 반려 (미구현) |

---

## 근무타입 (Shift Type)

| 약어 | 이름 | 카테고리 | 색상 |
|------|------|----------|------|
| D | 주간 | WORK | 파랑 |
| N | 야간 | WORK | 보라 |
| OFF | 휴무 | OFF | 초록 |
| V | 휴가 | VACATION | 노랑 |
| T | 교육 | TRAINING | 핑크 |

매니저가 지점별로 근무타입을 커스터마이징 가능합니다.

---

## 휴가 정책

- **기본 일일 최대 인원**: 지점당 설정 (기본값: 3명)
- **날짜별 오버라이드**: 특정 날짜에 한해 최대 인원 변경 가능
- 근무자가 휴가(V)를 배정할 때 해당 날짜의 제한을 초과하면 경고

---

## 데이터 모델 요약

- **Branch**: 지점 (삼성 강북점 등)
- **User**: 사용자 (Google 계정 연동, 역할 + 지점 소속)
- **ShiftType**: 근무타입 (지점별 커스텀)
- **MonthlySchedule**: 월별 스케줄 (유저+년+월 단위, 상태 관리)
- **DailyAssignment**: 일별 근무 배정 (스케줄 내 각 날짜에 근무타입 매핑)
- **VacationLimit**: 휴가 제한 (지점별 기본값 + 날짜별 오버라이드)
- **CalendarEvent**: 캘린더 이벤트 (지점 공유)

---

## API 엔드포인트 요약

### 인증
| Method | Path | 설명 |
|--------|------|------|
| POST | `/api/auth/google` | Google 로그인 |
| POST | `/api/auth/register` | 회원가입 |
| POST | `/api/auth/refresh` | 토큰 갱신 |
| GET | `/api/auth/me` | 내 정보 조회 |

### 근무자
| Method | Path | 설명 |
|--------|------|------|
| GET | `/api/schedules/{year}/{month}` | 월별 스케줄 조회 |
| PUT | `/api/schedules/{year}/{month}/assignments` | 근무 배정 저장 |
| POST | `/api/schedules/{year}/{month}/submit` | 스케줄 제출 |

### 매니저
| Method | Path | 설명 |
|--------|------|------|
| GET | `/api/manager/team/schedules` | 팀 스케줄 조회 |
| GET/POST/PUT/DELETE | `/api/manager/shift-types/**` | 근무타입 관리 |
| GET/PUT/POST/DELETE | `/api/manager/vacation-limits/**` | 휴가 제한 관리 |
| GET/POST/PUT/DELETE | `/api/manager/events/**` | 이벤트 관리 |

### 공유 캘린더
| Method | Path | 설명 |
|--------|------|------|
| GET | `/api/branch/calendar/monthly` | 월간 캘린더 |
| GET | `/api/branch/calendar/weekly` | 주간 캘린더 |

### 기타
| Method | Path | 설명 |
|--------|------|------|
| GET | `/api/branches` | 지점 목록 (공개) |
| POST | `/api/dev/token` | 개발용 토큰 발급 |
