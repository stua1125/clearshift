# ClearShift — 교대 근무자용 공유 캘린더 앱

## 프로젝트 개요
교대 근무자가 월별 스케줄을 Paint Mode로 입력하고, 매니저가 팀 스케줄을 관리하는 모바일 앱.

## 기술 스택
- Flutter 3.x (Dart)
- State: Riverpod (code generation, @riverpod)
- Navigation: GoRouter
- Model: Freezed (@freezed, immutable)
- Architecture: Feature-First Clean Architecture

## 디자인 레퍼런스
- Figma: https://www.figma.com/design/8MyfHco2LWfMUHbmZTxjWG/공유-캘린더
- docs/figma-screens/ — 10개 화면 스크린샷

## 코딩 컨벤션
- 파일명: snake_case
- const constructor 최대한 활용
- build() 메서드 50줄 이하, 초과 시 하위 위젯 분리
- Magic number 금지 → AppColors, AppSpacing 상수 사용
- 불필요한 주석 없이 자기 문서화 코드
- 모든 모델은 @freezed로 정의
- Provider는 @riverpod annotation 사용

## 네비게이션 (통일 3탭)
- 홈 (`/home`): 공유 캘린더 (월간/주간)
- 근무신청 (`/schedule`): Paint Mode 스케줄 입력
- 설정 (`/settings`): 허브 → 근무타입/휴가/이벤트 관리

## 근무타입 기본값
MD(오전), AF(오후), NI(야간), HD(휴무)

## 프로젝트 구조
```
lib/
├── core/theme/           # 디자인 토큰 (colors, typography, spacing, theme)
├── core/widgets/         # 공용 위젯 (ShiftBadge, DayCell, PaintToolbar 등)
├── core/constants/       # 상수 정의 (defaultShiftTypes)
├── core/router/          # GoRouter (3탭 + push routes)
├── features/shared_calendar/  # 공유 캘린더 (홈탭)
├── features/worker/      # 근무자 기능 (근무신청탭)
├── features/settings/    # 설정 허브
├── features/manager/     # 매니저 기능 (근무타입/휴가/이벤트)
├── features/auth/        # 인증
└── shared/               # 공유 모델, 서비스
```

## 진행 상태
- [x] Phase 0: 사전 준비
- [x] Phase 1: 프로젝트 구조 + 의존성
- [x] Phase 2: 디자인 시스템
- [x] Phase 3: 공용 위젯
- [x] Phase 4: Worker 캘린더 (Paint Mode)
- [x] Phase 5: Manager 화면
- [x] Phase 6: Figma 디자인 리팩터링 (10개 화면)
- [ ] Phase 7: 백엔드 연동 + 실 데이터
