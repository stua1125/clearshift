# ShiftFlow Design System — Claude Code Implementation Prompt

> 이 문서는 Claude Code에서 Flutter 프로젝트의 디자인 시스템을 구현할 때 사용하는 프롬프트입니다.
> CLAUDE.md 또는 docs/ 디렉토리에 배치하여 Claude Code의 컨텍스트로 활용하세요.

---

## 프롬프트 사용법

Claude Code에서 `/init` 실행 후, 아래 프롬프트를 단계별로 입력합니다.

---

## Phase 1: 프로젝트 초기화 프롬프트

```
나는 "ShiftFlow"라는 스케줄 근무자용 캘린더 앱을 Flutter로 개발하고 있어.
Feature-First Clean Architecture + Riverpod + GoRouter 구조를 사용할 거야.

프로젝트 구조를 다음과 같이 생성해줘:

lib/
├── app.dart                          # MaterialApp, GoRouter, Theme 설정
├── main.dart                         # Entry point
├── core/
│   ├── theme/
│   │   ├── app_colors.dart           # 디자인 시스템 컬러
│   │   ├── app_typography.dart       # 텍스트 스타일
│   │   ├── app_spacing.dart          # 간격 상수
│   │   ├── app_shadows.dart          # 그림자 스타일
│   │   └── app_theme.dart            # ThemeData 조합
│   ├── widgets/                      # 공용 위젯
│   │   ├── shift_badge.dart
│   │   ├── app_bottom_sheet.dart
│   │   └── app_button.dart
│   ├── constants/
│   │   └── shift_types.dart          # 기본 근무타입 정의
│   └── router/
│       └── app_router.dart           # GoRouter 설정
├── features/
│   ├── auth/                         # 로그인
│   ├── worker/                       # 근무자 기능
│   │   ├── calendar/                 # W-01 월별 캘린더 + Paint Mode
│   │   │   ├── presentation/
│   │   │   │   ├── worker_calendar_screen.dart
│   │   │   │   ├── widgets/
│   │   │   │   │   ├── calendar_grid.dart
│   │   │   │   │   ├── day_cell.dart
│   │   │   │   │   ├── paint_toolbar.dart
│   │   │   │   │   └── submit_bar.dart
│   │   │   │   └── providers/
│   │   │   │       └── calendar_provider.dart
│   │   │   ├── domain/
│   │   │   │   ├── models/
│   │   │   │   └── repositories/
│   │   │   └── data/
│   │   │       ├── repositories/
│   │   │       └── datasources/
│   │   └── my_schedule/              # W-02 내 스케줄 요약
│   ├── manager/                      # 매니저 기능
│   │   ├── calendar/                 # M-01, M-02 월별/주별 캘린더
│   │   ├── shift_types/              # M-03 근무타입 CRUD
│   │   ├── vacation_settings/        # M-04 휴가 MAX 관리
│   │   ├── events/                   # M-05 이벤트 관리
│   │   └── team/                     # M-06 팀원 스케줄 상세
│   └── admin/                        # 관리자 기능
└── shared/
    ├── models/
    │   ├── user.dart
    │   ├── shift_type.dart
    │   ├── daily_assignment.dart
    │   └── monthly_schedule.dart
    └── services/
        ├── api_client.dart
        └── auth_service.dart

먼저 이 폴더 구조만 생성하고, 각 파일에는 TODO 주석만 넣어줘.
```

---

## Phase 2: 디자인 시스템 구현 프롬프트

```
ShiftFlow의 디자인 시스템을 구현해줘.
디자인 레퍼런스는 "Shift Work Planner" 앱이야.

핵심 디자인 특성:
- 컬러풀한 pill 형태의 근무 뱃지가 캘린더 셀에 표시
- 하단에 summary bar (근무일수, 시간 등 실시간 표시)
- Paint mode에서 근무타입 선택 후 날짜 탭으로 일괄 등록
- 깔끔한 흰색 배경 + 둥근 카드 UI
- 색상 코딩으로 패턴을 한눈에 파악

### app_colors.dart

다음 컬러 시스템을 구현해줘:

// Background & Surface
- background: #F7F8FA (앱 전체 배경)
- surface: #FFFFFF (카드, 셀)
- surfaceVariant: #F1F3F5 (비활성 영역)

// Primary
- primary: #3B82F6 (주 액션, 오늘 날짜 강조)
- primaryContainer: #DBEAFE
- onPrimary: #FFFFFF

// Text
- textPrimary: #111827
- textSecondary: #6B7280
- textTertiary: #9CA3AF
- textOnColor: #FFFFFF

// Border
- border: #E5E7EB
- borderLight: #F3F4F6
- borderFocus: #3B82F6

// Status
- success: #10B981 (제출 완료, 승인)
- warning: #F59E0B (작성 중, 주의)
- error: #EF4444 (반려, MAX 초과)

// Shift Type Colors (근무타입별 고유 색상)
- shiftDay: #3B82F6 (주간)
- shiftDayBg: #DBEAFE
- shiftNight: #7C3AED (야간)
- shiftNightBg: #EDE9FE
- shiftOff: #10B981 (휴무)
- shiftOffBg: #D1FAE5
- shiftVacation: #F59E0B (휴가)
- shiftVacationBg: #FEF3C7
- shiftTraining: #EC4899 (교육)
- shiftTrainingBg: #FCE7F3

// Calendar
- calendarSunday: #EF4444
- calendarSaturday: #3B82F6
- calendarToday: border 2px #3B82F6 + ring shadow
- calendarCellHover: #F9FAFB

// Dark Mode 변형도 함께 정의 (ColorScheme.dark 기반)

### app_typography.dart

Pretendard 폰트 패밀리 사용 (fallback: -apple-system, system-ui).
Google Fonts 패키지로 Noto Sans KR을 대안으로 사용 가능.

- displayLarge: 24sp Bold (월 표시 "2026년 3월")
- titleMedium: 16sp SemiBold (섹션 제목)
- titleSmall: 14sp SemiBold (카드 제목)
- bodyMedium: 14sp Regular (본문)
- bodySmall: 12sp Regular (부가 정보)
- labelLarge: 12sp Bold (버튼 텍스트)
- labelSmall: 10sp SemiBold (뱃지, 캡션)
- calendarDay: 12sp Medium (날짜 숫자)
- calendarDaySunday: 12sp Medium color=calendarSunday
- calendarDaySaturday: 12sp Medium color=calendarSaturday
- shiftBadge: 9sp Bold (근무타입 약어)

### app_spacing.dart

4px 기반 spacing scale:
- xs: 4, sm: 8, md: 12, lg: 16, xl: 20, xxl: 24, xxxl: 32

Calendar specific:
- cellHeight: 56 (mobile), 80 (tablet)
- cellGap: 4
- cellPadding: 4
- cellBorderRadius: 8

Card:
- cardBorderRadius: 16
- cardPadding: 16
- cardElevation: 0 (border 기반, shadow 없음)

### app_shadows.dart

- none: 기본 (border 기반 디자인)
- sm: BoxShadow(offset: 0,1, blur: 2, color: #0000000D)
- md: BoxShadow(offset: 0,2, blur: 8, color: #0000001A) — floating 요소
- focus: BoxShadow(offset: 0,0, blur: 0, spread: 2, color: primary.withOpacity(0.2))

### app_theme.dart

위 토큰들을 조합한 ThemeData를 생성해줘.
- useMaterial3: true
- 모든 색상은 ColorScheme 기반
- AppBarTheme: backgroundColor transparent, elevation 0, scrolledUnderElevation 0
- CardTheme: shape RoundedRectangle(16), elevation 0, border 1px borderLight
- ElevatedButtonTheme: 둥근 full-radius, bold 텍스트
- InputDecorationTheme: OutlineInputBorder radius 12
- BottomSheetTheme: radius 20, dragHandle 표시
- BottomNavigationBarTheme: Material3 NavigationBar 스타일
```

---

## Phase 3: 핵심 공용 위젯 프롬프트

```
ShiftFlow의 핵심 공용 위젯을 구현해줘.

### 1. ShiftBadge (shift_badge.dart)

Shift Work Planner 스타일의 pill 형태 근무 뱃지.

Props:
- shiftType: ShiftType (id, label, abbreviation, color, bgColor)
- size: ShiftBadgeSize.sm | md | lg
  - sm: height 18, fontSize 9, padding horizontal 6
  - md: height 22, fontSize 11, padding horizontal 8
  - lg: height 28, fontSize 13, padding horizontal 10
- selected: bool (true면 ring + shadow 효과)

스타일:
- Container with BoxDecoration
- borderRadius: full (stadium)
- background: shiftType.bgColor
- text: shiftType.abbreviation, color: shiftType.color, fontWeight: Bold
- selected 상태: border 1.5px shiftType.color + boxShadow(color.withOpacity(0.3))

### 2. DayCell (day_cell.dart)

캘린더 그리드의 개별 날짜 셀. shift-calendar-prototype.jsx의 날짜 셀을 Flutter로 포팅.

Props:
- day: int
- shift: ShiftType? (배정된 근무타입)
- event: CalendarEvent? (이벤트)
- isToday: bool
- isSunday: bool
- isSaturday: bool
- isPaintMode: bool
- vacationInfo: (current: int, max: int)? (매니저 뷰 전용)
- onTap: VoidCallback

레이아웃:
- Container: height cellHeight, borderRadius 8, border 1px
- isToday: border primary 2px + Container shadow focus
- 배정된 경우: background shiftType.bgColor.withOpacity(0.25)
- Stack 구조:
  - 좌상단: 날짜 숫자 (요일별 색상)
  - 우상단: ShiftBadge (sm)
  - 하단: 이벤트 chip (있을 경우) 또는 vacationInfo 텍스트

인터랙션:
- isPaintMode true: 탭 시 scale 0.95 → 1.0 애니메이션 (100ms)
- GestureDetector with onTap
- InkWell 대신 GestureDetector 사용 (커스텀 애니메이션 위해)
- 햅틱 피드백: HapticFeedback.lightImpact() on tap

### 3. PaintToolbar (paint_toolbar.dart)

shift-calendar-prototype.jsx의 Paint Toolbar를 Flutter로 포팅.

Props:
- shiftTypes: List<ShiftType>
- selectedType: ShiftType?
- isPaintMode: bool
- onSelectType: (ShiftType?) -> void
- onTogglePaint: VoidCallback

레이아웃:
- Card(borderRadius 16) 안에:
  - Row: "근무 타입 선택" 레이블 + Paint ON/OFF 토글 버튼
  - Wrap(spacing 6): 근무타입 버튼들 + 지우기 버튼
- 각 근무타입 버튼: ShiftBadge(lg) 스타일 + 왼쪽에 작은 원형 dot
- 선택된 타입: scale 1.05 + ring + shadow
- 비선택: opacity 0.6
- Paint ON 버튼: 활성 시 primary 색상 pill, 비활성 시 gray pill
- 지우기 버튼: gray 스타일 + 🧹 이모지

### 4. SubmitBar (submit_bar.dart)

Props:
- filledCount: int
- totalDays: int
- status: SubmissionStatus (draft, submitted, approved, rejected)
- onSubmit: VoidCallback

레이아웃:
- Card(borderRadius 16) 안에:
  - Row: 작성 현황 텍스트 + 제출 버튼/상태 뱃지
  - LinearProgressIndicator: 퍼센트 바 (height 6, borderRadius full)
  - 색상: <50% warning, 50~99% primary, 100% success
- 제출 버튼: 100%일 때만 활성화
  - 활성: ElevatedButton primary + shadow
  - 비활성: gray background, disabled
- submitted 상태: "✓ 제출 완료" success chip

### 5. CalendarGrid (calendar_grid.dart)

월별 캘린더 그리드 전체를 감싸는 위젯.

Props:
- year: int, month: int
- assignments: Map<int, ShiftType>
- events: List<CalendarEvent>
- onDayTap: (int day) -> void
- isPaintMode: bool
- selectedShiftType: ShiftType?
- role: UserRole

레이아웃:
- Column:
  - 요일 헤더 Row (일~토, 색상 적용)
  - GridView.builder (crossAxisCount: 7, childAspectRatio 기반)
  - 첫 주 앞의 빈 셀은 SizedBox
  - 각 셀은 DayCell 위젯

성능:
- const constructor 활용
- RepaintBoundary로 각 DayCell 감싸기
- 불필요한 rebuild 방지를 위해 Riverpod select 사용
```

---

## Phase 4: 근무자 메인 화면 프롬프트

```
Worker 캘린더 메인 화면을 구현해줘.
경로: lib/features/worker/calendar/

shift-calendar-prototype.jsx의 인터랙션을 그대로 구현하되,
Flutter의 네이티브 터치 피드백(햅틱, 리플)을 추가해.

### Riverpod Provider 구조

@riverpod
class WorkerCalendar extends _$WorkerCalendar {
  // State: CalendarState (year, month, assignments, paintMode, selectedShiftType, submissionStatus)
  // Methods:
  //   selectShiftType(ShiftType?)
  //   togglePaintMode()
  //   tapDay(int day)  → Paint Mode일 때 assignment 토글
  //   submitSchedule() → 모든 날짜 배정 시에만 실행
  //   navigateMonth(int delta)
  //   loadSchedule()  → API에서 기존 스케줄 로드
}

### 화면 구성 (worker_calendar_screen.dart)

Scaffold:
- AppBar 없음 (커스텀 헤더)
- body: SafeArea > SingleChildScrollView > Column:
  1. 커스텀 헤더: 앱 로고 + 역할 표시
  2. MonthNavigator: < [2026년 3월] > (좌우 화살표, 가운데 년월)
  3. CalendarGrid
  4. PaintToolbar
  5. SubmitBar
  6. 범례 (Legend): 근무타입 색상 + 레이블 가로 나열

Paint Mode 핵심 동작:
1. PaintToolbar에서 ShiftType 선택
2. CalendarGrid의 DayCell 탭
3. Provider의 tapDay(day) 호출
4. 이미 같은 타입이면 삭제 (토글), 다른 타입이면 교체
5. selectedShiftType이 null이면 지우기 모드
6. DayCell에 즉각적 시각 피드백 (scale + color transition)
7. 탭 시 HapticFeedback.lightImpact()
8. SubmitBar의 progress 실시간 업데이트

Auto-save:
- assignment가 변경될 때마다 debounce 2초 후 API에 저장
- 네트워크 에러 시 로컬 저장 (SharedPreferences) → 재시도
```

---

## Phase 5: 매니저 화면 프롬프트

```
Manager 캘린더 화면과 관리 기능을 구현해줘.

### M-01 매니저 캘린더

- 월간/주간 토글 (SegmentedButton)
- 월간: CalendarGrid (매니저 뷰) — 각 셀에 이벤트 + 휴가현황 표시
- 주간: 가로 테이블 (팀원 × 요일)
- 날짜 탭 → BottomSheet로 해당 일자 팀원 전체 배정 상세

### M-03 근무타입 관리

- ListView로 현재 타입 목록
- 각 항목: ShiftBadge + 이름 + 편집/삭제 아이콘
- FAB → 새 타입 추가 BottomSheet
- ReorderableListView로 드래그 정렬

### M-04 휴가 MAX 관리

- 기본 MAX: Stepper(− 숫자 +) 위젯
- Override 추가: 날짜 입력 + MAX 입력 + 적용 버튼
- Override 목록: Wrap으로 Chip 나열, 각 Chip에 삭제(×) 버튼
- Chip 스타일: amber 배경, "12일: 5명" 형식

### M-05 이벤트 관리

- 캘린더에서 날짜 롱프레스 → 이벤트 추가 BottomSheet
- 제목, 색상 선택 (5가지 프리셋), 메모
- 기존 이벤트 탭 → 편집 BottomSheet

### 팀원 현황 카드

- Card 안에 ListView
- 각 행: CircleAvatar(이니셜, 고유색상) + 이름 + 상태 badge
- 상태: "제출 완료"(success), "작성중 73%"(warning), "미시작"(gray)
- 탭 → 해당 팀원 상세 스케줄 화면으로 이동
```

---

## CLAUDE.md에 추가할 코딩 컨벤션

```markdown
## Coding Conventions

### Dart/Flutter
- Riverpod: @riverpod annotation 기반 (code generation)
- Freezed: 모든 model은 @freezed로 immutable 정의
- 파일 네이밍: snake_case
- 위젯: 최대 build() 50줄. 초과 시 하위 위젯으로 분리
- const: 가능한 모든 곳에 const constructor 사용
- Magic number 금지: AppSpacing, AppColors 상수 사용

### 테스트
- Widget test: 각 공용 위젯 (ShiftBadge, DayCell, PaintToolbar, SubmitBar)
- Provider test: CalendarProvider의 tapDay, submitSchedule 로직
- Golden test: 주요 화면 스크린샷 비교

### Git Commit
- feat: 새 기능
- fix: 버그 수정
- style: 디자인/UI 변경
- refactor: 코드 구조 개선
- test: 테스트 추가/수정

### PR 단위
- 화면 1개 = PR 1개 (예: W-01 근무자 캘린더)
- 디자인 시스템 = 별도 PR
- API 연동 = 별도 PR
```

---

## 실행 순서 요약

| 순서 | 프롬프트 | 결과물 | 예상 시간 |
|------|---------|--------|----------|
| 1 | Phase 1 | 폴더 구조 + TODO 파일 | 5분 |
| 2 | Phase 2 | 디자인 토큰 (colors, typography, spacing, theme) | 15분 |
| 3 | Phase 3 | 공용 위젯 5개 | 30분 |
| 4 | Phase 4 | Worker 캘린더 메인 (Paint Mode) | 45분 |
| 5 | Phase 5 | Manager 화면들 | 60분 |
| 6 | 추가 | API 연동, 인증, 오프라인 지원 | 별도 |

각 Phase 완료 후 반드시:
1. `flutter analyze` 실행하여 lint 확인
2. 에뮬레이터에서 화면 확인
3. git commit
4. PLAN.md 업데이트
