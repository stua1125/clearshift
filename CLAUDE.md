# ClearShift — 교대 근무자용 공유 캘린더 웹앱

## 프로젝트 개요
교대 근무자가 월별 스케줄을 Paint Mode로 입력하고, 매니저가 팀 스케줄을 관리하는 웹 애플리케이션.

## 기술 스택

### Frontend (`frontend/`)
- Next.js 15 (App Router) + TypeScript
- State: TanStack Query v5 (서버) + Zustand (클라이언트)
- Styling: Tailwind CSS v4 + shadcn/ui
- Form: React Hook Form + Zod
- HTTP: Axios (JWT 인터셉터)
- Font: Pretendard
- PWA: next-pwa

### Backend (`backend/`)
- Spring Boot 3.x + Java 21
- Auth: JWT + Google OAuth 2.0
- DB: PostgreSQL 16 (Docker)
- API Docs: SpringDoc OpenAPI 3.0 (Swagger UI)

## 스펙 문서
- `SPEC.md` — 통합 요구사항 + 디자인 가이드라인 + API 스펙

## 디자인 레퍼런스
- 톤앤매너: 토스의 깔끔함 + TimeTree의 공유 캘린더 구조
- Figma: https://www.figma.com/design/8MyfHco2LWfMUHbmZTxjWG/공유-캘린더
- docs/figma-screens/ — 화면 스크린샷

## 코딩 컨벤션
- 파일명: kebab-case (Next.js 관례)
- 컴포넌트: PascalCase
- Magic number 금지 → Tailwind 설정 또는 상수 사용
- 자기 문서화 코드, 불필요한 주석 없음
- 타입 정의는 `src/types/` 에 집중 관리

## 네비게이션 (하단 3탭)
- 홈 (`/home`): 공유 캘린더 (월간/주간)
- 근무신청 (`/schedule`): Paint Mode 스케줄 입력
- 설정 (`/settings`): 허브 → 근무타입/휴가/이벤트 관리

## 근무타입 기본값
오전, 오후, 야간, 휴무

## 프로젝트 구조
```
frontend/
├── src/
│   ├── app/                 # App Router (라우팅)
│   │   ├── (main)/          # 하단 탭 레이아웃 그룹
│   │   │   ├── home/
│   │   │   ├── schedule/
│   │   │   └── settings/
│   │   ├── settings/        # 설정 하위 (탭 없음)
│   │   └── auth/
│   ├── components/
│   │   ├── ui/              # shadcn/ui
│   │   ├── calendar/        # 캘린더 그리드
│   │   ├── paint/           # PaintToolbar, SubmitBar
│   │   └── common/          # ShiftBadge, BottomNav
│   ├── hooks/               # 커스텀 훅
│   ├── lib/api/             # Axios, API 함수
│   ├── stores/              # Zustand 스토어
│   └── types/               # TypeScript 타입
backend/
├── src/main/java/com/clearshift/
└── docker-compose.yml
```

## 개발 명령어
```bash
# Frontend
cd frontend && npm install
npm run dev                    # http://localhost:3000

# Backend (Docker)
cd backend && docker-compose up -d   # PostgreSQL + API
./gradlew bootRun                     # http://localhost:8080

# Swagger UI
open http://localhost:8080/swagger-ui.html
```

## data-testid (E2E 테스트 타겟팅)
- PaintToolbar: `paint-mode-toggle`, `shift-btn-{오전|오후|야간|휴무}`, `eraser-btn`
- DayCell: `day-cell-{day}`
- SubmitBar: `submit-button`
- SharedCalendar: `prev-month`, `next-month`, `view-monthly`, `view-weekly`
- WorkerCalendar: `prev-month-worker`, `next-month-worker`
- Settings: `settings-{title}`

# currentDate
Today's date is 2026-03-27.
