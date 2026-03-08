# ClearShift User Flow (Figma Design Reference)

> Figma MCP 연동용 유저 플로우 정의서
> 각 Flow는 Figma Frame으로 구성, 화살표로 연결

---

## Flow 1: 온보딩 (Onboarding)

### 1.1 앱 진입
```
[Splash Screen]
  │
  ▼
{로그인 상태 확인}
  ├─ 로그인됨 → [공유 캘린더 (SC-01)]
  └─ 비로그인 → [Login Screen]
```

### 1.2 로그인
```
[Login Screen]
  │ Google 로그인 버튼 탭
  ▼
{Google OAuth}
  │ ID Token 획득
  ▼
{백엔드 인증}
  ├─ 기존 회원 → JWT 발급 → [공유 캘린더 (SC-01)]
  └─ 미가입 → [Register Screen]
```

### 1.3 회원가입
```
[Register Screen]
  │ ① 이름 입력 (TextField)
  │ ② 지점 선택 (Dropdown → API: GET /api/branches)
  │ ③ 가입하기 버튼
  ▼
{백엔드 등록} → JWT 발급 → [공유 캘린더 (SC-01)]
```

---

## Flow 2: 공유 캘린더 (모든 구성원 공통)

> 제출된 스케줄은 승인 없이 즉시 공유 캘린더에 반영됩니다 (Google Calendar 정책)

### 2.1 SC-01 월간 공유 캘린더 (메인)
```
[Shared Calendar Screen - Monthly]
  ├── Header: 앱 로고 + 역할 뱃지
  ├── MonthNavigator: < 2026년 3월 >
  ├── ViewToggle: [월간] [주간]
  ├── SharedCalendarGrid: 7열 날짜 그리드
  │   └── SharedDayCell 구성:
  │       ├── 날짜 (좌상단)
  │       ├── 근무타입별 인원수 (중앙): "D:3 N:2 OFF:1" (컬러 미니뱃지)
  │       └── 이벤트 칩 (하단): 색상 dot + 제목
  └── BottomNav: [공유 캘린더] [내 스케줄] [설정]
```

### 2.2 SC-02 월간 날짜 상세 (DayDetailSheet)
```
[SharedDayCell 탭]
  ▼
[Day Detail BottomSheet]
  ├── 날짜 표시: "3월 5일 (목)"
  ├── 근무 배정 섹션
  │   ├── 근무타입별 그룹
  │   │   ├── D 주간 (3명): 김철수, 이영희, 박지민
  │   │   ├── N 야간 (2명): 홍길동, 최수진
  │   │   └── OFF 휴무 (1명): 정민수
  │   └── 미제출: 2명
  └── 이벤트 섹션
      └── 이벤트 목록 (해당 날짜)
```

### 2.3 SC-03 주간 공유 캘린더 (Google Calendar 스타일)
```
[ViewToggle → 주간 탭]
  ▼
[Shared Calendar Screen - Weekly]
  ├── WeekNavigator: < 3월 1주차 (1~7일) >
  ├── 요일 헤더: [월1] [화2] [수3] [목4] [금5] [토6] [일7]
  ├── 이벤트 바: 색상 바 + 이벤트 제목 (해당 날짜 열에 걸쳐 표시)
  └── 7열 DayColumn 그리드 (Google Calendar 주간 뷰 스타일):
      ├── 각 열 = 하루 (세로 방향)
      └── 열 안에 해당 날짜 배정된 워커들이 세로로 쌓임:
          ├── [월1일 열]: 김철수 D, 이영희 N, 박지민 OFF
          ├── [화2일 열]: 김철수 D, 이영희 N, 박지민 D
          ├── [수3일 열]: 김철수 N, 이영희 D, 박지민 D
          └── ...
      각 워커 카드: ShiftBadge 색상 배경 + 약어 + 이름 (세로 카드)
```

### 2.4 주/월 이동
```
[MonthNavigator / WeekNavigator]
  ├─ < 이전 탭 → 이전 월/주 로드
  └─ 다음 > 탭 → 다음 월/주 로드
```

---

## Flow 3: Worker 내 스케줄 (근무 신청)

> Worker 전용 화면. Paint Mode로 근무를 배정하고 제출합니다.

### 3.1 W-01 내 스케줄 화면
```
[My Schedule Screen]
  ├── Header: "내 스케줄" + 월 표시
  ├── MonthNavigator: < 2026년 3월 >
  ├── CalendarGrid: 7열 날짜 그리드 (내 배정만 표시)
  ├── PaintToolbar: Paint ON/OFF + 근무타입 버튼
  ├── SubmitBar: 진행률 + 제출 버튼
  └── Legend: 근무타입 색상 범례
```

### 3.2 Paint Mode 인터랙션
```
[PaintToolbar]
  │ ① Paint ON 탭
  ▼
{Paint Mode 활성화}
  │ ② 근무타입 선택 (D/N/OFF/V/T/지우기)
  ▼
[CalendarGrid]
  │ ③ 날짜 셀 탭
  ▼
{배정 로직}
  ├─ 빈 셀 → 선택 타입 배정 (셀 배경색 변경 + Scale 애니메이션)
  ├─ 같은 타입 → 해제 (토글)
  ├─ 다른 타입 → 교체
  └─ 지우기 → 기존 배정 삭제
  │
  ▼
[SubmitBar 자동 업데이트]
  │ 진행률: {배정됨}/{전체일수} (%)
  │ 100% 달성 시 → 제출 버튼 활성화
  ▼
{제출하기 탭}
  │ API: POST /api/schedules/{year}/{month}/submit
  ▼
[SubmitBar → "제출 완료" 상태]
  │ 즉시 공유 캘린더에 반영됨
```

### 3.3 제출 후 수정
```
{제출 완료 상태}
  │ 수정이 필요할 때
  ▼
[Paint Mode 켜기] → 수정 시 자동으로 DRAFT로 전환
  │ 수정 완료 후
  ▼
{재제출}
```

---

## Flow 4: Manager 관리 기능

> 매니저 전용 설정 화면. 공유 캘린더는 모든 구성원과 동일한 화면 사용.

### 4.1 M-01 근무타입 관리
```
[Navigation: /manager/shift-types]
  ▼
[Shift Types Screen]
  ├── ReorderableListView
  │   └── 행: ShiftBadge + 이름 + 편집/삭제
  └── FAB (+)
      ▼
      [ShiftType Form BottomSheet]
        ├── 이름 (TextField)
        ├── 약어 1~3자 (TextField)
        ├── 색상 프리셋 (5가지 Circle)
        ├── 카테고리 (Dropdown: WORK/OFF/VACATION/TRAINING)
        └── 저장 버튼
```

### 4.2 M-02 휴가 MAX 관리
```
[Navigation: /manager/vacation-settings]
  ▼
[Vacation Settings Screen]
  ├── 기본 MAX: Stepper (− 숫자 +)
  │   └── PUT /api/manager/vacation-limits
  └── Override 섹션
      ├── 날짜 선택 + MAX 입력 → 추가
      │   └── POST /api/manager/vacation-limits/overrides
      └── Chip 목록 (amber "12일: 5명" + 삭제 ×)
          └── DELETE /api/manager/vacation-limits/overrides/{id}
```

### 4.3 M-03 이벤트 관리
```
[Navigation: /manager/events]
  ▼
[Events Screen]
  ├── 이벤트 리스트
  │   └── 이벤트 탭 → [Event Form BottomSheet] (편집)
  └── FAB (+) → [Event Form BottomSheet] (신규)

[Event Form BottomSheet]
  ├── 제목 (TextField)
  ├── 시작일 / 종료일 (DatePicker)
  ├── 색상 (5가지 Circle: 파랑/보라/초록/주황/빨강)
  ├── 메모 (TextField, 2줄)
  └── 저장 버튼
```

---

## Flow 5: 네비게이션 구조

```
[BottomNavigationBar]
  ├── 모든 사용자 공통
  │   ├── 📅 공유 캘린더 (SC-01/SC-03) → 월간/주간 토글
  │   ├── 📋 내 스케줄 (W-01) → Paint Mode 근무 신청
  │   └── ⚙️ 설정
  │       ├── Worker: 프로필, 로그아웃
  │       └── Manager: 근무타입(M-01), 휴가설정(M-02), 이벤트(M-03), 프로필, 로그아웃
  └── 역할별 차이
      ├── Worker: 내 스케줄에서 Paint Mode로 근무 신청
      └── Manager: 설정 메뉴에서 근무타입/휴가/이벤트 관리
```

---

## 상태 다이어그램

### Schedule Status (간소화)
```
DRAFT → SUBMITTED (제출 즉시 공유 캘린더 반영)
SUBMITTED → DRAFT (수정 시 자동 전환, 재제출 필요)
```

### Paint Mode State
```
OFF → ON (타입 선택 필요)
ON + 타입 선택 → 날짜 탭 가능
ON + 지우기 → 날짜 탭 시 삭제
ON → OFF (Paint 해제)
```

---

## 색상 시스템 (Figma Styles)

| Token | Hex | 용도 |
|-------|-----|------|
| primary | #3B82F6 | 주간(D), 주요 액션 |
| shiftNight | #7C3AED | 야간(N) |
| shiftOff | #10B981 | 휴무(OFF) |
| shiftVacation | #F59E0B | 휴가(V) |
| shiftTraining | #EC4899 | 교육(T) |
| background | #F7F8FA | 앱 배경 |
| surface | #FFFFFF | 카드/시트 배경 |
| textPrimary | #111827 | 본문 텍스트 |
| textSecondary | #6B7280 | 보조 텍스트 |
| error | #EF4444 | 에러 |
| success | #10B981 | 성공 |
