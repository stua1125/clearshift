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
  ├─ 로그인됨 → [역할 분기] → Worker? → [W-01 Worker Calendar]
  │                         → Manager? → [M-01 Manager Calendar]
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
  ├─ 기존 회원 → JWT 발급 → [역할 분기]
  └─ 미가입 → [Register Screen]
```

### 1.3 회원가입
```
[Register Screen]
  │ ① 이름 입력 (TextField)
  │ ② 지점 선택 (Dropdown → API: GET /api/branches)
  │ ③ 가입하기 버튼
  ▼
{백엔드 등록} → JWT 발급 → [역할 분기]
```

---

## Flow 2: Worker (근무자)

### 2.1 W-01 월별 캘린더 (메인)
```
[Worker Calendar Screen]
  ├── Header: 앱 로고 + 역할 표시
  ├── MonthNavigator: < 2026년 3월 >
  ├── CalendarGrid: 7열 날짜 그리드
  ├── PaintToolbar: Paint ON/OFF + 근무타입 버튼
  ├── SubmitBar: 진행률 + 제출 버튼
  └── Legend: 근무타입 색상 범례
```

### 2.2 Paint Mode 인터랙션
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
```

### 2.3 월 이동
```
[MonthNavigator]
  ├─ < 이전월 탭 → month-1 로드
  └─ 다음월 > 탭 → month+1 로드
```

---

## Flow 3: Manager (매니저)

### 3.1 M-01 매니저 월별 캘린더
```
[Manager Calendar Screen]
  ├── MonthNavigator: < 2026년 3월 >
  ├── CalendarGrid (매니저 뷰)
  │   ├── 날짜 + 이벤트 chip
  │   └── 휴가 {현재}/{MAX} 표시
  ├── TeamOverview 카드
  │   └── 팀원 리스트: Avatar + 이름 + 상태 뱃지
  └── 뷰 전환 탭: 월별 | 주별
```

### 3.2 날짜 상세 조회
```
[CalendarGrid 날짜 탭]
  ▼
[Day Detail BottomSheet]
  ├── 날짜 표시
  └── 팀원별 배정 현황 리스트
      └── Avatar + 이름 + ShiftBadge
```

### 3.3 팀원 스케줄 상세
```
[TeamOverview 팀원 탭]
  │ 네비게이션: /manager/team/:memberId/schedule
  ▼
[Member Schedule Screen]
  ├── MemberInfo: Avatar + 이름 + 역할
  ├── CalendarGrid (읽기 전용)
  ├── StatsSummary: 근무 통계 카드
  ├── SubmitBar: 제출 상태 표시
  └── ActionButtons
      ├── [반려] → PATCH status=REJECTED
      └── [승인] → PATCH status=APPROVED
```

### 3.4 M-02 주별 캘린더
```
[주별 탭 전환]
  ▼
[Weekly Calendar View]
  ├── DataTable: 행=팀원, 열=요일(일~토)
  ├── 셀: ShiftBadge
  └── 좌우 스와이프: 주 이동
```

### 3.5 M-03 근무타입 관리
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

### 3.6 M-04 휴가 MAX 관리
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

### 3.7 M-05 이벤트 관리
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

## Flow 4: 네비게이션 구조

```
[BottomNavigationBar] (향후 구현)
  ├── Worker
  │   ├── 캘린더 (W-01)
  │   └── 내 스케줄 (W-02, 향후)
  └── Manager
      ├── 캘린더 (M-01/M-02)
      ├── 근무타입 (M-03)
      ├── 휴가설정 (M-04)
      ├── 이벤트 (M-05)
      └── 팀원 상세 (M-06, 팀원 탭에서 진입)
```

---

## 상태 다이어그램

### Schedule Status
```
DRAFT → SUBMITTED → APPROVED
                  → REJECTED → DRAFT (재수정)
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
| error | #EF4444 | 에러/반려 |
| success | #10B981 | 성공/승인 |
