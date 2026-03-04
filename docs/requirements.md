# ShiftFlow - 요구사항 명세서 (Requirements Specification)

## 1. 프로젝트 개요

### 1.1 목적
스케줄 근무자를 위한 크로스플랫폼 모바일 캘린더 앱. 근무자가 월별 근무 스케줄을 직접 입력하고 제출하며, 매니저가 팀 스케줄을 관리·조회할 수 있는 시스템.

### 1.2 기술 스택
- **Frontend**: Flutter 3.x (Dart)
- **Backend**: Spring Boot 3.x + Java 21
- **Database**: PostgreSQL
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Architecture**: Feature-First Clean Architecture

### 1.3 사용자 역할 (Roles)

| Role | 설명 | 권한 수준 |
|------|------|----------|
| Admin | 시스템 관리자 | 전체 시스템 설정, 매니저/근무자 계정 관리, 조직 구조 설정 |
| Manager | 팀 관리자 | 근무조·근무타입 CRUD, 휴가 MAX 관리, 이벤트 등록, 팀원 스케줄 조회 |
| Worker | 근무자 | 본인 스케줄 입력·제출, 캘린더 조회 |

---

## 2. 화면별 상세 스펙

### 2.1 공통 (Shared)

#### S-01. 스플래시 / 로그인

- **Route**: `/login`
- **UI 요소**: 앱 로고, 이메일/비밀번호 입력, 로그인 버튼, 비밀번호 찾기 링크
- **동작**: JWT 토큰 기반 인증. 로그인 성공 시 role에 따라 라우팅
  - Admin → `/admin/dashboard`
  - Manager → `/manager/calendar`
  - Worker → `/worker/calendar`
- **상태**: `AuthState { isLoading, isAuthenticated, user, error }`

#### S-02. 하단 네비게이션 바

- Worker: 캘린더 | 내 스케줄 | 알림 | 마이페이지
- Manager: 캘린더 | 팀 관리 | 알림 | 설정
- Admin: 대시보드 | 조직 관리 | 설정

---

### 2.2 근무자 화면 (Worker)

#### W-01. 월별 캘린더 (메인 화면)

- **Route**: `/worker/calendar`
- **레이아웃**:
  ```
  ┌─────────────────────────────────┐
  │  < 2026년 3월 >    [Paint ON]  │  ← 월 네비게이션 + Paint 토글
  ├─────────────────────────────────┤
  │  일  월  화  수  목  금  토     │  ← 요일 헤더 (일=빨강, 토=파랑)
  ├─────────────────────────────────┤
  │  [1] [2] [3] [4] [5] [6] [7]  │
  │   D       N   V   D       OFF  │  ← 날짜 셀 + 근무타입 뱃지
  │  [8] [9] ...                   │
  │                                │
  ├─────────────────────────────────┤
  │  ● 주간  ● 야간  ● 휴무       │  ← Paint Toolbar (근무타입 선택)
  │  ● 휴가  ● 교육  🧹 지우기    │
  ├─────────────────────────────────┤
  │  작성 현황: 23/31일  ▓▓▓▓░ 74% │  ← Progress Bar
  │                    [제출하기]   │  ← Submit (100% 시 활성화)
  └─────────────────────────────────┘
  ```

- **핵심 인터랙션: Paint Mode**
  1. Paint Toolbar에서 근무타입 하나를 선택 (선택된 타입은 ring + scale 강조)
  2. 캘린더의 날짜 셀을 탭하면 해당 날짜에 선택된 근무타입이 배정됨
  3. 이미 같은 타입이 배정된 날짜를 다시 탭하면 배정 해제 (토글)
  4. "지우기" 선택 후 탭하면 기존 배정 삭제
  5. Paint OFF 시 탭 비활성화 (조회 전용)

- **날짜 셀 구조**:
  - 좌상단: 날짜 숫자 (일=빨강, 토=파랑, 평일=회색)
  - 우상단: 근무타입 ShiftBadge (약어 + 배경색)
  - 하단: 이벤트 칩 (있을 경우)
  - 오늘 날짜: 파란색 ring 강조
  - 배정된 날짜: 해당 타입 배경색 (투명도 40%)

- **Submit Bar**:
  - Progress: `{배정된 일수}/{해당 월 총 일수}` + 퍼센트 바
  - 퍼센트 바 색상: <50% 주황, 50~99% 파랑, 100% 초록
  - 제출 버튼: 100% 완료 시에만 활성화
  - 제출 완료 상태: "✓ 제출 완료" 뱃지 표시, 수정 불가
  - 제출 후 수정 필요 시: 매니저에게 "반려 요청" → 매니저가 반려 시 재작성 가능

- **상태**:
  ```
  CalendarState {
    year: int
    month: int
    assignments: Map<int, ShiftType>  // day → shift type
    paintMode: bool
    selectedShiftType: ShiftType?
    submissionStatus: draft | submitted | approved | rejected
  }
  ```

#### W-02. 내 스케줄 요약

- **Route**: `/worker/my-schedule`
- **내용**: 이번 달 근무 통계 (주간 N일, 야간 N일, 휴무 N일, 휴가 N일), 다음 근무 일정, 제출 이력

---

### 2.3 매니저 화면 (Manager)

#### M-01. 월별 캘린더 (매니저 메인)

- **Route**: `/manager/calendar`
- **레이아웃**:
  ```
  ┌─────────────────────────────────┐
  │  < 2026년 3월 >  [월간][주간]  │  ← 월 네비게이션 + View 토글
  ├─────────────────────────────────┤
  │  일  월  화  수  목  금  토     │
  ├─────────────────────────────────┤
  │  [1]       [2]       [3]  ...  │
  │  안전교육   V:2/3              │  ← 이벤트 + 휴가 현황
  │  ...                           │
  ├─────────────────────────────────┤
  │  ┌── 팀원 현황 ──────────────┐ │
  │  │ 🟦 김민수  제출 완료       │ │
  │  │ 🟪 이서연  작성중 73%     │ │
  │  │ 🟩 박지훈  작성중 45%     │ │
  │  └───────────────────────────┘ │
  └─────────────────────────────────┘
  ```

- **날짜 셀 (매니저 뷰)**: 날짜, 이벤트 칩, 휴가 현황 `{현재}/{MAX}` (MAX 도달 시 빨간색)
- **팀원 현황 카드**: 프로필 아바타 + 이름 + 제출 상태 (badge)
- **탭하여 상세**: 특정 날짜 탭 → 해당 일자 전체 팀원 근무 배정 상세 BottomSheet

#### M-02. 주별 캘린더

- **Route**: `/manager/calendar?view=week`
- **레이아웃**: 가로 스크롤 테이블. 행=팀원, 열=요일 (월~일). 셀에 ShiftBadge 표시
- **인터랙션**: 좌우 스와이프로 주 이동

#### M-03. 근무타입 관리

- **Route**: `/manager/shift-types`
- **CRUD 기능**:
  - 생성: 이름, 약어(1~3자), 색상, 카테고리(근무조/휴가/기타)
  - 수정: 모든 필드 편집 가능
  - 삭제: 사용 중인 타입은 soft delete (비활성화)
  - 순서 변경: 드래그&드롭 정렬

- **기본 제공 타입**:
  ```
  주간(D) #3B82F6 | 야간(N) #7C3AED | 휴무(OFF) #10B981
  휴가(V) #F59E0B | 교육(T) #EC4899
  ```

#### M-04. 휴가 MAX 관리

- **Route**: `/manager/vacation-settings`
- **기능**:
  - 일일 기본 휴가 MAX 설정 (Stepper UI: − / 숫자 / +)
  - 특정 일자 Override: 날짜 선택 → MAX 값 조정 (증가 또는 감소)
  - Override 목록: chip 형태로 표시 `12일: 5명` (삭제 가능)
  - 캘린더에서 실시간 반영: 해당 일자 셀에 `{현재}/{조정된 MAX}` 표시

#### M-05. 이벤트 관리

- **Route**: `/manager/events`
- **생성**: 제목, 날짜 (단일 또는 범위), 색상, 메모
- **표시**: 캘린더 날짜 셀 하단에 color-coded chip
- **수정/삭제**: 이벤트 탭 → 편집 BottomSheet

#### M-06. 팀원 스케줄 상세

- **Route**: `/manager/team/:memberId/schedule`
- **내용**: 특정 팀원의 월별 스케줄 전체 조회. 승인/반려 액션 버튼

---

### 2.4 관리자 화면 (Admin)

#### A-01. 대시보드

- **Route**: `/admin/dashboard`
- **내용**: 전체 팀 수, 매니저/근무자 수, 이번 달 제출률, 미제출 팀 현황

#### A-02. 조직 관리

- **Route**: `/admin/organization`
- **기능**: 팀 생성/수정/삭제, 매니저 배정, 근무자 초대 (이메일), Role 변경

---

## 3. 데이터 모델 (핵심 Entity)

```
User {
  id: UUID
  email: String
  name: String
  role: ADMIN | MANAGER | WORKER
  teamId: UUID?
}

Team {
  id: UUID
  name: String
  managerId: UUID
}

ShiftType {
  id: UUID
  teamId: UUID
  name: String           // "주간"
  abbreviation: String   // "D"
  color: String          // "#3B82F6"
  category: WORK | LEAVE | OTHER
  sortOrder: Int
  isActive: Boolean
}

MonthlySchedule {
  id: UUID
  userId: UUID
  year: Int
  month: Int
  status: DRAFT | SUBMITTED | APPROVED | REJECTED
  submittedAt: Timestamp?
}

DailyAssignment {
  id: UUID
  scheduleId: UUID
  day: Int               // 1~31
  shiftTypeId: UUID
}

VacationLimit {
  id: UUID
  teamId: UUID
  defaultMax: Int
}

VacationLimitOverride {
  id: UUID
  vacationLimitId: UUID
  date: LocalDate
  maxCount: Int
}

CalendarEvent {
  id: UUID
  teamId: UUID
  title: String
  startDate: LocalDate
  endDate: LocalDate
  color: String
  memo: String?
}
```

---

## 4. API 엔드포인트 (주요)

### 인증
- `POST /api/auth/login` — 로그인 (JWT 발급)
- `POST /api/auth/refresh` — 토큰 갱신

### 근무자
- `GET /api/schedules/{year}/{month}` — 내 월별 스케줄 조회
- `PUT /api/schedules/{year}/{month}/assignments` — 일별 배정 저장 (auto-save)
- `POST /api/schedules/{year}/{month}/submit` — 스케줄 제출

### 매니저
- `GET /api/manager/team/schedules?year=&month=` — 팀 전체 스케줄 조회
- `PATCH /api/manager/schedules/{id}/status` — 승인/반려
- `CRUD /api/manager/shift-types` — 근무타입 관리
- `GET/PUT /api/manager/vacation-limits` — 휴가 MAX 관리
- `PUT /api/manager/vacation-limits/overrides` — 특정 일자 Override
- `CRUD /api/manager/events` — 이벤트 관리

### Admin
- `CRUD /api/admin/teams` — 팀 관리
- `CRUD /api/admin/users` — 사용자 관리

---

## 5. 비기능 요구사항

### 5.1 성능
- 캘린더 화면 초기 로딩: < 1초
- Paint Mode 탭 반응: < 100ms (즉각적 피드백)
- 오프라인 지원: 캘린더 조회 및 배정 입력 가능, 온라인 복귀 시 자동 동기화

### 5.2 알림
- 스케줄 제출 마감 리마인더 (매니저가 설정한 마감일 기준)
- 스케줄 승인/반려 알림
- 이벤트 리마인더
- Push Notification (FCM)

### 5.3 보안
- JWT + Refresh Token
- Role 기반 API 접근 제어 (Spring Security)
- 비밀번호 BCrypt 암호화

### 5.4 접근성
- 최소 터치 타겟: 44x44dp
- 색상만으로 정보 전달하지 않음 (텍스트 약어 병행)
- 다크 모드 지원
