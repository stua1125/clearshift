# ShiftFlow — Claude Code 실행 가이드

> Phase별로 Plan Mode → 실행 모드 전환하며 개발하는 실전 워크플로우

---

## 0. 사전 준비

### 0-1. Flutter 프로젝트 생성

```bash
flutter create --org com.shiftflow --project-name shiftflow .
cd shiftflow
```

### 0-2. CLAUDE.md 작성

프로젝트 루트에 `CLAUDE.md` 파일을 생성합니다.
Claude Code는 **매 세션 시작 시 이 파일을 자동으로 읽어서** 프로젝트 컨텍스트로 사용합니다.

```bash
cat > CLAUDE.md << 'EOF'
# ShiftFlow — 스케줄 근무자용 캘린더 앱

## 프로젝트 개요
교대 근무자가 월별 스케줄을 Paint Mode로 입력하고, 매니저가 팀 스케줄을 관리하는 모바일 앱.

## 기술 스택
- Flutter 3.x (Dart)
- State: Riverpod (code generation, @riverpod)
- Navigation: GoRouter
- Model: Freezed (@freezed, immutable)
- Architecture: Feature-First Clean Architecture

## 디자인 레퍼런스
- Shift Work Planner (Google Play) — 컬러풀 pill 뱃지, Paint Mode
- shift-calendar-prototype.jsx (docs/ 디렉토리) — 날짜 탭 인터랙션

## 코딩 컨벤션
- 파일명: snake_case
- const constructor 최대한 활용
- build() 메서드 50줄 이하, 초과 시 하위 위젯 분리
- Magic number 금지 → AppColors, AppSpacing 상수 사용
- 불필요한 주석 없이 자기 문서화 코드
- 모든 모델은 @freezed로 정의
- Provider는 @riverpod annotation 사용

## 프로젝트 구조
lib/
├── core/theme/        # 디자인 토큰 (colors, typography, spacing, theme)
├── core/widgets/      # 공용 위젯 (ShiftBadge, DayCell, PaintToolbar 등)
├── core/constants/    # 상수 정의
├── core/router/       # GoRouter
├── features/worker/   # 근무자 기능
├── features/manager/  # 매니저 기능
├── features/admin/    # 관리자 기능
├── features/auth/     # 인증
└── shared/            # 공유 모델, 서비스

## 현재 진행 상태
- [ ] Phase 1: 프로젝트 구조 + 의존성
- [ ] Phase 2: 디자인 시스템
- [ ] Phase 3: 공용 위젯
- [ ] Phase 4: Worker 캘린더 (Paint Mode)
- [ ] Phase 5: Manager 화면
EOF
```

### 0-3. 기획 문서 배치

```bash
mkdir -p docs
# 이전에 생성한 파일들을 docs/ 디렉토리에 복사
cp requirements.md docs/
cp claude-code-design-system-prompt.md docs/
cp shift-calendar-prototype.jsx docs/
```

### 0-4. Claude Code 시작

```bash
claude --permission-mode plan
```

> **`--permission-mode plan`** 으로 시작하면 Plan Mode가 기본 활성화됩니다.
> 세션 중 모드 전환: `Shift+Tab` 2번 (Normal → Auto-Accept → Plan)

---

## 1. Phase 1: 프로젝트 구조 + 의존성 설정

### Step 1-1. Plan Mode에서 구조 계획 요청

```
@docs/requirements.md @docs/claude-code-design-system-prompt.md 를 읽고,
ShiftFlow 프로젝트의 Phase 1을 계획해줘.

목표:
1. Feature-First Clean Architecture 폴더 구조 생성
2. pubspec.yaml에 의존성 추가 (riverpod, go_router, freezed, google_fonts, shared_preferences)
3. 각 파일에 TODO 주석만 넣기 (아직 구현하지 않음)

계획을 PLAN.md에 저장해줘.
```

> Claude가 코드베이스를 분석하고 PLAN.md를 생성합니다.

### Step 1-2. 계획 검토 및 수정

```
Ctrl+G
```

> 에디터에서 PLAN.md가 열립니다. 직접 수정 후 저장하세요.
> 대화로 수정하는 것보다 **파일을 직접 편집하는 것이 더 정확합니다.**

### Step 1-3. 실행 모드로 전환하여 구현

```
Shift+Tab  (Plan → Normal 또는 Auto-Accept로 전환)
```

```
PLAN.md의 Phase 1을 실행해줘.
폴더 구조 생성 + pubspec.yaml 의존성 추가 + 각 파일에 TODO 주석.
완료 후 flutter pub get 실행해서 의존성 확인해줘.
```

### Step 1-4. 검증 및 커밋

```
flutter pub get && flutter analyze 실행해줘.
에러 없으면 git add -A && git commit -m "feat: Phase 1 - 프로젝트 구조 및 의존성 설정" 해줘.
CLAUDE.md의 Phase 1 체크박스를 완료로 업데이트해줘.
```

---

## 2. Phase 2: 디자인 시스템 구현

### Step 2-1. Plan Mode로 전환 후 계획

```
Shift+Tab Shift+Tab  (Plan Mode 진입)
```

```
@docs/claude-code-design-system-prompt.md 의 Phase 2 섹션을 참고해서
디자인 시스템 구현 계획을 세워줘.

구현 대상:
- lib/core/theme/app_colors.dart
- lib/core/theme/app_typography.dart
- lib/core/theme/app_spacing.dart
- lib/core/theme/app_shadows.dart
- lib/core/theme/app_theme.dart

디자인 레퍼런스: Shift Work Planner 앱
- 컬러풀 pill 뱃지, 흰색 배경, 둥근 카드
- 근무타입별 고유 색상 체계 (#3B82F6 주간, #7C3AED 야간 등)

PLAN.md를 업데이트해줘.
```

### Step 2-2. 실행

```
Shift+Tab  (실행 모드 전환)
```

```
PLAN.md의 Phase 2를 실행해줘.
디자인 토큰 5개 파일을 모두 구현하고,
app_theme.dart에서 ThemeData로 조합해줘.
useMaterial3: true 적용.
```

### Step 2-3. 검증 및 커밋

```
flutter analyze 실행하고, 에러 없으면
git add -A && git commit -m "feat: Phase 2 - 디자인 시스템 (colors, typography, spacing, shadows, theme)" 해줘.
CLAUDE.md Phase 2 체크박스 업데이트.
```

---

## 3. Phase 3: 공용 위젯

### Step 3-1. Plan Mode에서 위젯별 상세 계획

```
Shift+Tab Shift+Tab  (Plan Mode)
```

```
@docs/claude-code-design-system-prompt.md 의 Phase 3,
@docs/shift-calendar-prototype.jsx 를 참고해서
공용 위젯 구현 계획을 세워줘.

위젯 5개:
1. ShiftBadge - pill 형태 근무 뱃지 (sm/md/lg)
2. DayCell - 캘린더 날짜 셀 (탭 피드백, 햅틱)
3. PaintToolbar - 근무타입 선택 바 + Paint ON/OFF
4. SubmitBar - Progress Bar + 제출 버튼
5. CalendarGrid - 월별 7열 그리드

shift-calendar-prototype.jsx의 인터랙션을 Flutter로 정확히 포팅하는 게 핵심이야.
각 위젯의 Props, 레이아웃, 애니메이션을 상세히 계획해줘.
PLAN.md 업데이트.
```

### Step 3-2. 위젯을 하나씩 실행 (작은 단위로)

```
Shift+Tab  (실행 모드)
```

```
Phase 3의 위젯을 하나씩 구현해줘. 순서:

1번: ShiftBadge 먼저 구현.
- lib/shared/models/shift_type.dart (@freezed 모델 포함)
- lib/core/widgets/shift_badge.dart
완료 후 flutter analyze.
```

```
2번: DayCell 구현.
- shift-calendar-prototype.jsx의 날짜 셀 동작을 그대로 포팅
- 탭 시 scale 0.95→1.0 (100ms), HapticFeedback.lightImpact()
- isToday, isSunday, isSaturday 색상 처리
완료 후 flutter analyze.
```

```
3번: PaintToolbar 구현.
- 근무타입 버튼 Wrap + Paint ON/OFF 토글
- 선택된 타입: ring + scale 1.05 + shadow
완료 후 flutter analyze.
```

```
4번: SubmitBar 구현.
- Progress bar + 제출 버튼 + 상태별 UI
완료 후 flutter analyze.
```

```
5번: CalendarGrid 구현.
- GridView.builder, crossAxisCount: 7
- DayCell 조합 + 요일 헤더
- RepaintBoundary로 성능 최적화
완료 후 flutter analyze.
```

### Step 3-3. 커밋

```
git add -A && git commit -m "feat: Phase 3 - 공용 위젯 (ShiftBadge, DayCell, PaintToolbar, SubmitBar, CalendarGrid)" 해줘.
CLAUDE.md Phase 3 체크박스 업데이트.
```

---

## 4. Phase 4: Worker 캘린더 메인 화면

### Step 4-1. Plan Mode

```
Shift+Tab Shift+Tab  (Plan Mode)
```

```
@docs/requirements.md 의 W-01 화면 스펙,
@docs/shift-calendar-prototype.jsx 를 참고해서
Worker 캘린더 메인 화면 구현 계획을 세워줘.

핵심:
- Riverpod provider로 상태 관리 (CalendarState)
- Paint Mode: 타입 선택 → 날짜 탭 → 즉시 배정 (토글)
- 모든 날짜 배정 완료 시 제출 활성화
- Auto-save: debounce 2초
- 기존 Phase 3 위젯들을 조합

파일 목록과 의존 관계를 명확히 계획해줘.
PLAN.md 업데이트.
```

### Step 4-2. Provider → Screen 순서로 실행

```
Shift+Tab  (실행 모드)
```

```
Phase 4를 다음 순서로 구현해줘:

Step A: 모델 정의
- lib/shared/models/daily_assignment.dart
- lib/shared/models/monthly_schedule.dart
- lib/shared/models/calendar_event.dart

Step B: Provider 구현
- lib/features/worker/calendar/presentation/providers/calendar_provider.dart
- CalendarState: year, month, assignments, paintMode, selectedShiftType, submissionStatus
- tapDay(), selectShiftType(), togglePaintMode(), submitSchedule(), navigateMonth()

Step C: Screen 조합
- lib/features/worker/calendar/presentation/worker_calendar_screen.dart
- 커스텀 헤더 + MonthNavigator + CalendarGrid + PaintToolbar + SubmitBar + Legend
- 모든 위젯을 Provider로 연결

각 Step 완료 후 flutter analyze 실행.
```

### Step 4-3. 에뮬레이터에서 확인

```
main.dart를 수정해서 Worker 캘린더가 홈 화면으로 뜨게 해줘.
GoRouter에 /worker/calendar 라우트 추가하고 initialLocation으로 설정.
flutter run으로 실행 가능하도록 app.dart도 완성해줘.
```

### Step 4-4. 커밋

```
flutter analyze && git add -A && git commit -m "feat: Phase 4 - Worker 캘린더 메인 화면 (Paint Mode)" 해줘.
CLAUDE.md Phase 4 체크박스 업데이트.
```

---

## 5. Phase 5: Manager 화면

### Step 5-1. Plan Mode

```
Shift+Tab Shift+Tab  (Plan Mode)
```

```
@docs/requirements.md 의 M-01 ~ M-06 화면 스펙을 참고해서
Manager 화면 전체 구현 계획을 세워줘.

화면 목록:
- M-01: 매니저 월별 캘린더 (팀원 현황 + 휴가 카운트)
- M-02: 주별 캘린더 (팀원 × 요일 테이블)
- M-03: 근무타입 CRUD
- M-04: 휴가 MAX 관리 (기본 MAX + 일자별 Override)
- M-05: 이벤트 CRUD
- M-06: 팀원 스케줄 상세 (승인/반려)

각 화면을 독립 PR 단위로 나눠서 계획해줘.
PLAN.md 업데이트.
```

### Step 5-2. 화면 하나씩 실행

```
Shift+Tab  (실행 모드)
```

```
M-01 매니저 월별 캘린더를 구현해줘.
- CalendarGrid를 매니저 뷰로 확장 (이벤트 + 휴가 현황 표시)
- TeamOverview 위젯 (팀원 제출 현황 카드)
- 날짜 탭 → BottomSheet (해당 일자 팀원 배정 상세)
완료 후 flutter analyze.
```

```
git add -A && git commit -m "feat: M-01 매니저 월별 캘린더"
```

```
M-03 근무타입 관리를 구현해줘.
- ReorderableListView로 드래그 정렬
- FAB → 추가 BottomSheet (이름, 약어, 색상, 카테고리)
- 편집/삭제
완료 후 flutter analyze.
```

```
git add -A && git commit -m "feat: M-03 근무타입 CRUD"
```

> M-02, M-04, M-05, M-06도 동일 패턴으로 하나씩 구현 + 커밋합니다.

---

## 워크플로우 요약 다이어그램

```
┌─────────────────────────────────────────────────────┐
│                   각 Phase 반복                      │
│                                                     │
│  ① Plan Mode 진입                                   │
│     claude --permission-mode plan                   │
│     또는 Shift+Tab × 2                              │
│            │                                        │
│            ▼                                        │
│  ② 계획 요청 (@ 레퍼런스 파일 첨부)                  │
│     "Phase N을 계획해줘. PLAN.md 업데이트."           │
│            │                                        │
│            ▼                                        │
│  ③ PLAN.md 검토/수정                                │
│     Ctrl+G로 에디터에서 직접 편집                     │
│            │                                        │
│            ▼                                        │
│  ④ 실행 모드 전환                                    │
│     Shift+Tab (Normal 또는 Auto-Accept)              │
│            │                                        │
│            ▼                                        │
│  ⑤ 작은 단위로 구현 지시                              │
│     "PLAN.md Phase N의 Step A를 실행해줘."           │
│            │                                        │
│            ▼                                        │
│  ⑥ 검증                                             │
│     flutter analyze + 에뮬레이터 확인                 │
│            │                                        │
│            ▼                                        │
│  ⑦ 커밋 + CLAUDE.md 업데이트                         │
│     git commit + 체크박스 완료 표시                   │
│            │                                        │
│            ▼                                        │
│       다음 Phase로 →                                 │
└─────────────────────────────────────────────────────┘
```

---

## 자주 쓰는 명령어 모음

### 모드 전환

| 동작 | 방법 |
|------|------|
| Plan Mode로 시작 | `claude --permission-mode plan` |
| 세션 중 Plan 진입 | `Shift+Tab` 2번 |
| Plan에서 실행 전환 | `Shift+Tab` 1번 |
| Plan 직접 편집 | `Ctrl+G` |
| Auto-Accept (YOLO) | `Shift+Tab` 1번 (Normal에서) |
| 실행 중 중단 | `Esc` |

### 파일 레퍼런스

| 동작 | 방법 |
|------|------|
| 파일 참조 | `@docs/requirements.md` |
| 여러 파일 참조 | `@파일1 @파일2 를 읽고...` |
| 디렉토리 참조 | `@lib/core/theme/` |

### 세션 관리

| 동작 | 방법 |
|------|------|
| 새 세션 시작 | `claude` (CLAUDE.md 자동 로드) |
| 컨텍스트 확인 | `/cost` |
| 모델 확인 | `/model` |
| 커스텀 명령 | `/commands` |

### 유용한 프롬프트 패턴

```bash
# 계획 요청 (Plan Mode)
"@파일 을 참고해서 [기능]의 구현 계획을 세워줘. PLAN.md 업데이트."

# 실행 요청 (Normal/Auto Mode)
"PLAN.md의 Phase N, Step A를 실행해줘. 완료 후 flutter analyze."

# 검증 + 커밋
"flutter analyze 실행하고, 에러 없으면 git commit -m '메시지' 해줘."

# 디버깅
"flutter analyze에서 [에러] 발생. 수정해줘."

# 리팩토링
"[파일]의 build() 메서드가 너무 길어. 하위 위젯으로 분리해줘."
```

---

## 트러블슈팅

### Shift+Tab이 Plan Mode로 안 넘어갈 때

Windows 일부 터미널에서 `Shift+Tab`이 가로채질 수 있습니다.

```bash
# 대안 1: Alt+M 사용
Alt+M

# 대안 2: /plan 명령어 직접 입력
/plan

# 대안 3: 시작 시 플래그 지정
claude --permission-mode plan
```

### 컨텍스트가 너무 길어질 때

```bash
# 새 세션 시작 (CLAUDE.md + PLAN.md가 자동 로드되므로 컨텍스트 유지됨)
/clear

# 또는 터미널에서 새로 시작
claude
```

### 계획과 다르게 구현될 때

```
Esc  (실행 중단)
```

```
방금 작업을 되돌려줘. PLAN.md를 다시 확인하고,
Step B의 2번 항목부터 다시 실행해줘.
```
