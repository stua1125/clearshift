# ClearShift 실행 계획

> 교대 근무자용 공유 캘린더 앱 — Flutter 프론트엔드 개발 계획
> 각 Phase 완료 후: `flutter analyze` → git commit → CLAUDE.md 체크박스 업데이트

---

## Phase 0: 사전 준비

**목표**: Flutter 프로젝트 생성 + Git 초기화 + 문서 정리

| Step | 작업 | 명령어/파일 |
|------|------|------------|
| 0-1 | Flutter 프로젝트 생성 | `flutter create --org com.clearshift --project-name clearshift .` |
| 0-2 | CLAUDE.md 생성 | 프로젝트 개요, 기술 스택, 코딩 컨벤션, 진행 체크리스트 |
| 0-3 | docs/ 디렉토리 구성 | 기획 문서 이동 (requirements.md, design-system-prompt.md 등) |
| 0-4 | Git 초기화 + remote 연결 | `git init && git remote add origin git@github.com:stua1125/clearshift.git` |
| 0-5 | 초기 커밋 + push | `git add -A && git commit && git push -u origin main` |

**검증**: `flutter run` 기본 카운터 앱 실행 확인

---

## Phase 1: 프로젝트 구조 + 의존성

**목표**: Feature-First Clean Architecture 폴더 구조 + 패키지 의존성

### Step 1-1. pubspec.yaml 의존성 추가

**dependencies:**
- `flutter_riverpod` / `riverpod_annotation` — 상태 관리
- `go_router` — 네비게이션
- `freezed_annotation` / `json_annotation` — immutable 모델
- `google_fonts` — Pretendard/Noto Sans KR
- `shared_preferences` — 로컬 저장
- `intl` — 날짜 포맷

**dev_dependencies:**
- `riverpod_generator` / `riverpod_lint`
- `build_runner` / `freezed` / `json_serializable`
- `custom_lint`

### Step 1-2. 폴더 구조 생성

```
lib/
├── app.dart                          # MaterialApp, GoRouter, Theme
├── main.dart                         # Entry point (ProviderScope)
├── core/
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_typography.dart
│   │   ├── app_spacing.dart
│   │   ├── app_shadows.dart
│   │   └── app_theme.dart
│   ├── widgets/
│   │   ├── shift_badge.dart
│   │   ├── day_cell.dart
│   │   ├── paint_toolbar.dart
│   │   ├── submit_bar.dart
│   │   ├── calendar_grid.dart
│   │   ├── app_bottom_sheet.dart
│   │   └── app_button.dart
│   ├── constants/
│   │   └── shift_types.dart
│   └── router/
│       └── app_router.dart
├── features/
│   ├── auth/
│   ├── worker/
│   │   ├── calendar/
│   │   │   ├── presentation/
│   │   │   │   ├── worker_calendar_screen.dart
│   │   │   │   ├── widgets/
│   │   │   │   └── providers/
│   │   │   │       └── calendar_provider.dart
│   │   │   ├── domain/models/, repositories/
│   │   │   └── data/repositories/, datasources/
│   │   └── my_schedule/
│   ├── manager/
│   │   ├── calendar/
│   │   ├── shift_types/
│   │   ├── vacation_settings/
│   │   ├── events/
│   │   └── team/
│   └── admin/
└── shared/
    ├── models/
    │   ├── user.dart
    │   ├── shift_type.dart
    │   ├── daily_assignment.dart
    │   └── monthly_schedule.dart
    └── services/
        ├── api_client.dart
        └── auth_service.dart
```

### Step 1-3. 각 파일에 TODO 주석만 작성 (구현 X)

**검증**: `flutter pub get && flutter analyze`
**커밋**: `feat: Phase 1 - 프로젝트 구조 및 의존성 설정`

---

## Phase 2: 디자인 시스템

**목표**: 디자인 토큰 5개 파일 구현

### Step 2-1. app_colors.dart
| 카테고리 | 토큰 | 값 |
|---------|------|-----|
| Background | background | #F7F8FA |
| Background | surface | #FFFFFF |
| Background | surfaceVariant | #F1F3F5 |
| Primary | primary | #3B82F6 |
| Primary | primaryContainer | #DBEAFE |
| Primary | onPrimary | #FFFFFF |
| Text | textPrimary | #111827 |
| Text | textSecondary | #6B7280 |
| Text | textTertiary | #9CA3AF |
| Text | textOnColor | #FFFFFF |
| Border | border | #E5E7EB |
| Border | borderLight | #F3F4F6 |
| Border | borderFocus | #3B82F6 |
| Status | success | #10B981 |
| Status | warning | #F59E0B |
| Status | error | #EF4444 |
| Shift | shiftDay / shiftDayBg | #3B82F6 / #DBEAFE |
| Shift | shiftNight / shiftNightBg | #7C3AED / #EDE9FE |
| Shift | shiftOff / shiftOffBg | #10B981 / #D1FAE5 |
| Shift | shiftVacation / shiftVacationBg | #F59E0B / #FEF3C7 |
| Shift | shiftTraining / shiftTrainingBg | #EC4899 / #FCE7F3 |
| Calendar | calendarSunday | #EF4444 |
| Calendar | calendarSaturday | #3B82F6 |

- Dark Mode 변형도 함께 정의

### Step 2-2. app_typography.dart
- Pretendard 폰트 (fallback: Noto Sans KR via google_fonts)
- displayLarge: 24sp Bold (월 표시)
- titleMedium: 16sp SemiBold
- titleSmall: 14sp SemiBold
- bodyMedium: 14sp Regular
- bodySmall: 12sp Regular
- labelLarge: 12sp Bold (버튼)
- labelSmall: 10sp SemiBold (뱃지)
- calendarDay: 12sp Medium
- shiftBadge: 9sp Bold

### Step 2-3. app_spacing.dart
- Base: xs=4, sm=8, md=12, lg=16, xl=20, xxl=24, xxxl=32
- Calendar: cellHeight=56(mobile)/80(tablet), cellGap=4, cellPadding=4, cellBorderRadius=8
- Card: borderRadius=16, padding=16, elevation=0

### Step 2-4. app_shadows.dart
- none: 기본 (border 기반)
- sm: offset(0,1) blur(2) #0000000D
- md: offset(0,2) blur(8) #0000001A
- focus: spread(2) primary.withOpacity(0.2)

### Step 2-5. app_theme.dart
- useMaterial3: true
- ColorScheme 기반
- AppBarTheme: transparent, elevation 0
- CardTheme: RoundedRectangle(16), elevation 0, border 1px
- ElevatedButtonTheme: full-radius, bold
- InputDecorationTheme: OutlineInputBorder radius 12
- BottomSheetTheme: radius 20, dragHandle
- NavigationBarTheme: Material3

**검증**: `flutter analyze`
**커밋**: `feat: Phase 2 - 디자인 시스템`

---

## Phase 3: 핵심 공용 위젯

**목표**: 재사용 위젯 5개 + Freezed 모델

### Step 3-1. Freezed 모델 정의
- `lib/shared/models/shift_type.dart` — id, name, abbreviation, color, bgColor, category, sortOrder, isActive
- `lib/shared/models/calendar_event.dart` — id, teamId, title, startDate, endDate, color, memo
- `dart run build_runner build`

### Step 3-2. ShiftBadge
- **파일**: `lib/core/widgets/shift_badge.dart`
- Pill 형태 (StadiumBorder)
- Size: sm(h18, font9, px6), md(h22, font11, px8), lg(h28, font13, px10)
- Background: shiftType.bgColor, Text: shiftType.color + Bold
- selected: border 1.5px + boxShadow

### Step 3-3. DayCell
- **파일**: `lib/core/widgets/day_cell.dart`
- Container h=cellHeight, borderRadius=8, border 1px
- Stack: 좌상단 날짜(요일 색상), 우상단 ShiftBadge(sm), 하단 이벤트/vacationInfo
- isToday: primary 2px border + focus shadow
- 배정: bgColor.withOpacity(0.25)
- Paint Mode: GestureDetector + scale 0.95→1.0 (100ms) + HapticFeedback

### Step 3-4. PaintToolbar
- **파일**: `lib/core/widgets/paint_toolbar.dart`
- Card(borderRadius 16) > Row(레이블 + Paint 토글) + Wrap(근무타입 버튼 + 지우기)
- 선택: scale 1.05 + ring + shadow, 비선택: opacity 0.6
- Paint ON: primary pill, OFF: gray pill

### Step 3-5. SubmitBar
- **파일**: `lib/core/widgets/submit_bar.dart`
- Card > Row(현황 텍스트 + 제출 버튼) + LinearProgressIndicator(h6, radius full)
- 색상: <50% warning, 50~99% primary, 100% success
- 100%만 제출 활성화, submitted: "✓ 제출 완료" success chip

### Step 3-6. CalendarGrid
- **파일**: `lib/core/widgets/calendar_grid.dart`
- Column: 요일 헤더 Row(일~토) + GridView.builder(crossAxisCount: 7)
- 빈 셀 SizedBox, 각 셀 DayCell
- RepaintBoundary + const constructor

**검증**: `flutter analyze`
**커밋**: `feat: Phase 3 - 공용 위젯`

---

## Phase 4: Worker 캘린더 메인 화면 (W-01)

**목표**: Paint Mode 인터랙션 완성 + 앱 실행 가능

### Step 4-1. 추가 모델
- `lib/shared/models/daily_assignment.dart` (@freezed) — id, scheduleId, day, shiftTypeId
- `lib/shared/models/monthly_schedule.dart` (@freezed) — id, userId, year, month, status
- `dart run build_runner build`

### Step 4-2. Riverpod Provider
- **파일**: `lib/features/worker/calendar/presentation/providers/calendar_provider.dart`
- **State**: CalendarState { year, month, assignments: Map<int, ShiftType>, paintMode, selectedShiftType, submissionStatus }
- **Methods**:
  - `selectShiftType(ShiftType?)` — 근무타입 선택
  - `togglePaintMode()` — Paint ON/OFF
  - `tapDay(int day)` — 같은 타입이면 삭제(토글), 다른 타입이면 교체, null이면 지우기
  - `submitSchedule()` — 모든 날짜 배정 시에만 실행
  - `navigateMonth(int delta)` — 월 이동
  - `loadSchedule()` — API에서 기존 스케줄 로드

### Step 4-3. Worker Calendar Screen
- **파일**: `lib/features/worker/calendar/presentation/worker_calendar_screen.dart`
- Scaffold (AppBar 없음) > SafeArea > SingleChildScrollView > Column:
  1. 커스텀 헤더 (앱 로고 + 역할)
  2. MonthNavigator: `< 2026년 3월 >`
  3. CalendarGrid
  4. PaintToolbar
  5. SubmitBar
  6. Legend (근무타입 색상 + 레이블)

### Step 4-4. Router + App 설정
- `lib/core/router/app_router.dart` — GoRouter, initialLocation: /worker/calendar
- `lib/app.dart` — MaterialApp.router + AppTheme
- `lib/main.dart` — ProviderScope + App
- `lib/core/constants/shift_types.dart` — 기본 5개 근무타입 정의

### Paint Mode 동작 플로우
1. PaintToolbar에서 ShiftType 선택
2. CalendarGrid의 DayCell 탭
3. Provider.tapDay(day) 호출
4. 같은 타입 → 삭제, 다른 타입 → 교체, null → 지우기
5. DayCell 시각 피드백 (scale + color)
6. HapticFeedback.lightImpact()
7. SubmitBar progress 실시간 업데이트

**검증**: `flutter analyze` + 에뮬레이터에서 Paint Mode 동작
**커밋**: `feat: Phase 4 - Worker 캘린더 메인 화면`

---

## Phase 5: Manager 화면

**목표**: 매니저 기능 6개 화면 (각각 별도 커밋)

### Step 5-1. M-01 매니저 월별 캘린더
- **Route**: `/manager/calendar`
- CalendarGrid 매니저 뷰: 날짜 + 이벤트 chip + 휴가 `{현재}/{MAX}`
- TeamOverview 카드: CircleAvatar + 이름 + 상태 badge
- 날짜 탭 → BottomSheet (해당 일자 팀원 배정 상세)
- **커밋**: `feat: M-01 매니저 월별 캘린더`

### Step 5-2. M-02 주별 캘린더
- **Route**: `/manager/calendar?view=week`
- 가로 스크롤 테이블 (행=팀원, 열=요일)
- 셀에 ShiftBadge, 좌우 스와이프 주 이동
- **커밋**: `feat: M-02 매니저 주별 캘린더`

### Step 5-3. M-03 근무타입 CRUD
- **Route**: `/manager/shift-types`
- ReorderableListView: ShiftBadge + 이름 + 편집/삭제
- FAB → 추가 BottomSheet (이름, 약어 1~3자, 색상, 카테고리)
- **커밋**: `feat: M-03 근무타입 CRUD`

### Step 5-4. M-04 휴가 MAX 관리
- **Route**: `/manager/vacation-settings`
- 기본 MAX: Stepper(− 숫자 +)
- Override: 날짜 + MAX 입력 → Chip 목록 (amber "12일: 5명", 삭제 ×)
- **커밋**: `feat: M-04 휴가 MAX 관리`

### Step 5-5. M-05 이벤트 관리
- **Route**: `/manager/events`
- 캘린더 날짜 롱프레스 → 추가 BottomSheet (제목, 색상 5가지, 메모)
- 기존 이벤트 탭 → 편집 BottomSheet
- **커밋**: `feat: M-05 이벤트 관리`

### Step 5-6. M-06 팀원 스케줄 상세
- **Route**: `/manager/team/:memberId/schedule`
- 팀원 월별 스케줄 조회 + 승인/반려 버튼
- **커밋**: `feat: M-06 팀원 스케줄 상세`

**검증**: `flutter analyze` + 에뮬레이터에서 매니저 화면 전환 확인

---

## Phase 6: 추가 기능 (별도)

- [ ] 인증 (JWT 로그인/로그아웃, AuthState)
- [ ] API 연동 (Spring Boot 백엔드)
- [ ] 오프라인 지원 (SharedPreferences → 자동 동기화)
- [ ] 하단 네비게이션 바 (역할별 탭)
- [ ] Admin 화면 (A-01 대시보드, A-02 조직 관리)
- [ ] Push Notification (FCM)
- [ ] 다크 모드
- [ ] W-02 내 스케줄 요약

---

## 진행 상태

- [ ] Phase 0: 사전 준비
- [ ] Phase 1: 프로젝트 구조 + 의존성
- [ ] Phase 2: 디자인 시스템
- [ ] Phase 3: 공용 위젯
- [ ] Phase 4: Worker 캘린더
- [ ] Phase 5: Manager 화면
- [ ] Phase 6: 추가 기능
