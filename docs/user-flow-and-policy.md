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

## 앱 네비게이션 (통일 3탭)

하단 네비게이션 바: **홈 | 근무신청 | 설정**

### 탭 1: 홈 (`/home`) — 기본 화면

같은 지점(Branch) 소속 팀원의 스케줄을 조회하는 공유 캘린더

- **월간 뷰**: 날짜별 근무타입 인원수 요약 (MD:3, AF:2, NI:1 형태)
- **주간 뷰**: 팀원별 7일 단위 근무 배정 그리드
- 날짜 탭 → 근무 일정 상세 바텀시트 (근무그룹별 인원 + 이름)
- 캘린더 이벤트 표시

### 탭 2: 근무신청 (`/schedule`)

근무자가 Paint Mode로 자신의 월별 스케줄을 입력하는 화면

- **Paint OFF 상태**: 빈 캘린더 + 등록하기 버튼
- **Paint Mode ON**: 하단 패널에서 근무타입(MD/AF/NI/HD) 원형 버튼 선택 후 날짜 터치
- **제출 완료**: 작성 현황 100% + 제출 완료 카드 표시
- 작성 현황 진행률 바 + 제출하기 버튼

### 탭 3: 설정 (`/settings`)

설정 허브 메뉴 → 각 하위 화면은 push 방식 (뒤로가기 지원)

- **근무타입 관리** (`/settings/shift-types`): 필터탭(전체/활성/비활성), 드래그 정렬, CRUD
- **휴가 MAX 관리** (`/settings/vacation`): 기본 인원 + 날짜별 예외 설정
- **이벤트 관리** (`/settings/events`): 검색 + 이벤트 카드 목록, CRUD

---

## 화면 목록 (Figma 10개)

| # | 화면명 | 경로 | 설명 |
|---|--------|------|------|
| 1 | 공유 캘린더 - 월간 | `/home` | 월간 근무 인원수 요약 그리드 |
| 2 | 공유 캘린더 - 주간 | `/home` (주간 탭) | 팀원별 7일 근무 배정 |
| 3 | 공유 캘린더 - 상세 | `/home` (바텀시트) | 날짜별 근무그룹 상세 |
| 4 | 내 스케줄 - Paint OFF | `/schedule` | 빈 캘린더, 등록 대기 |
| 5 | 내 스케줄 - Paint ON | `/schedule` | Paint Mode 활성, 근무 입력 |
| 6 | 내 스케줄 - 제출 완료 | `/schedule` | 100% 완료, 제출 확인 |
| 7 | 근무타입 관리 | `/settings/shift-types` | 근무타입 목록 + 필터 |
| 8 | 근무타입 추가 폼 | `/settings/shift-types` (바텀시트) | 새 근무타입 생성 폼 |
| 9 | 휴가 MAX 설정 | `/settings/vacation` | 휴가 인원 제한 관리 |
| 10 | 이벤트 관리 | `/settings/events` | 이벤트 검색 + 목록 |

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

| 약어 | 이름 | 카테고리 | 색상 | 시간 |
|------|------|----------|------|------|
| MD | 오전 근무 | WORK | 파랑 #0064FF | 09:00-18:00 |
| AF | 오후 근무 | WORK | 주황 #FF9100 | 14:00-22:00 |
| NI | 야간 근무 | WORK | 보라 #6C5CE7 | 22:00-07:00 |
| HD | 휴무 | OFF | 회색 #94A3B8 | - |

매니저가 지점별로 근무타입을 커스터마이징 가능합니다 (이름, 약어, 색상, 시간).

---

## 휴가 정책

- **기본 일일 최대 인원**: 지점당 설정 (기본값: 3명)
- **날짜별 오버라이드**: 특정 날짜에 한해 최대 인원 변경 가능

---

## 데이터 모델 요약

- **Branch**: 지점 (삼성 강북점 등)
- **User**: 사용자 (Google 계정 연동, 역할 + 지점 소속)
- **ShiftType**: 근무타입 (지점별 커스텀, startTime/endTime 포함)
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
| GET | `/api/manager/shift-types?status=all` | 근무타입 목록 (필터: all/active/inactive) |
| POST/PUT/DELETE | `/api/manager/shift-types/**` | 근무타입 CRUD |
| PUT | `/api/manager/shift-types/reorder` | 근무타입 순서 변경 |
| GET | `/api/manager/events?q=검색어` | 이벤트 검색 |
| POST/PUT/DELETE | `/api/manager/events/**` | 이벤트 CRUD |
| GET/PUT/POST/DELETE | `/api/manager/vacation-limits/**` | 휴가 제한 관리 |

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
