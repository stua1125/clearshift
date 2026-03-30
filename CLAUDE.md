# ClearShift — 교대 근무자용 공유 캘린더 웹앱

## 프로젝트 개요
교대 근무자가 월별 스케줄을 항상 활성화된 Paint Mode로 입력하고, 매니저가 팀 스케줄을 관리하는 웹 애플리케이션.

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
- 근무신청 (`/schedule`): 항상 Paint Mode 활성 — 근무타입 선택 후 날짜 탭하여 입력
- 설정 (`/settings`): 허브 → 근무타입/휴가/이벤트 관리 (매니저 전용: ManagerGuard)

## 근무신청 화면 (Paint Mode)
- **항상 Paint Mode**: ON/OFF 토글 없음. 화면 진입 시 첫 번째 근무타입 자동 선택
- **상단**: "✏️ 근무신청" 타이틀 + 월 네비게이션
- **선택 상태 안내 바**: "● {근무타입명} 선택됨 — 탭하거나 드래그해서 등록"
- **캘린더 셀**: 날짜 + shift type 이름(오전/오후 등) 컬러 텍스트 + 배경 틴트
- **오늘 마커**: filled 파란 원
- **하단 Paint Toolbar**: 사각형 버튼(bgColor 배경 + 이름) + 라벨 + 지우개
- **제출 바**: 작성 현황 + 프로그레스 바 + "제출하기 (N%)" 버튼

## 근무타입 기본값
오전, 오후, 야간, 휴무

## API 엔드포인트 요약
- `GET /api/shift-types` — 활성 근무타입 조회 (인증된 사용자 누구나)
- `GET /api/manager/shift-types` — 전체 근무타입 관리 (매니저 전용)
- `GET /api/schedules/{year}/{month}` — 내 스케줄 조회
- `PUT /api/schedules/{year}/{month}/assignments` — 배정 저장
- `POST /api/schedules/{year}/{month}/submit` — 스케줄 제출
- `POST /api/dev/token?role={WORKER|MANAGER}&name={name}` — 개발용 토큰

## 프로젝트 구조
```
frontend/
├── src/
│   ├── app/                 # App Router (라우팅)
│   │   ├── (tabs)/          # 하단 탭 레이아웃 그룹
│   │   │   ├── home/
│   │   │   ├── schedule/
│   │   │   └── settings/
│   │   └── auth/
│   ├── components/          # 공용 컴포넌트
│   │   ├── ui/              # shadcn/ui
│   │   └── *.tsx            # calendar-grid, day-cell, paint-toolbar, submit-bar 등
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

# Swagger UI
open http://localhost:8080/swagger-ui.html
```

## data-testid (E2E 테스트 타겟팅)
- PaintToolbar: `shift-btn-{abbreviation}`, `eraser-btn`
- DayCell: `day-cell-{day}`
- SubmitBar: `submit-button`
- SharedCalendar: `prev-month`, `next-month`, `view-monthly`, `view-weekly`
- WorkerCalendar: `prev-month-worker`, `next-month-worker`
- Settings: `settings-{title}`

# currentDate
Today's date is 2026-03-27.
