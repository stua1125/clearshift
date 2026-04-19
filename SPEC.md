# ClearShift 통합 스펙 문서

> 교대 근무자용 공유 캘린더 앱 — 처음부터 재개발을 위한 기반 문서

---

## 1. 프로젝트 개요

### 1.1 목적

교대 근무자가 월별 근무 스케줄을 **Paint Mode**로 직관적으로 입력하고, 매니저가 팀 스케줄을 한눈에 관리할 수 있는 모바일 캘린더 앱.

### 1.2 타겟 유저

| 역할 | 설명 | 사용 빈도 |
|------|------|-----------|
| **Worker (근무자)** | 월별 스케줄 입력/제출, 공유 캘린더 조회 | 매일 |
| **Manager (매니저)** | 팀 스케줄 관리, 근무타입/휴가/이벤트 설정 | 매일~주간 |
| **Admin (관리자)** | 조직 구조 관리, 계정 관리 | 월간 (미구현) |

### 1.3 핵심 가치 제안

1. **직관적 스케줄 입력**: Paint Mode로 "색칠하듯" 근무 배정 — 스프레드시트 대체
2. **실시간 공유 캘린더**: 팀원 간 근무 현황 즉시 공유 — 전화/카톡 문의 감소
3. **체계적 스케줄 관리**: 제출→승인 워크플로우 — 수기 관리 탈피

---

## 2. 디자인 가이드라인

### 2.1 톤앤매너

**"토스의 깔끔함 + TimeTree의 공유 캘린더 구조"**

| 레퍼런스 | 차용 요소 |
|----------|-----------|
| **토스** | 깨끗한 white 배경, 미니멀 UI, 부드러운 인터랙션, 신뢰감 있는 블루 |
| **TimeTree** | 컬러 코드 기반 캘린더, 공유 구조, 날짜 셀 레이아웃 |
| **당직사자** | 교대 근무 특화 UX, 뱃지 기반 근무 표시 |
| **카카오워크** | 팀 협업 구조, 직관적 상태 표시 |

### 2.2 디자인 원칙

1. **One-Glance Clarity**: 화면을 보는 즉시 핵심 정보 파악 가능
2. **Touch-First**: 44dp 이상 터치 타겟, 한 손 조작 최적화
3. **Color as Data**: 색상이 근무 타입 정보를 전달 (단, 텍스트 약어 병행)
4. **Progressive Disclosure**: 핵심→세부 순서로 정보 노출
5. **Calm Interface**: 불필요한 장식 제거, 정보 밀도 최적화

### 2.3 컬러 시스템

#### Primary & Background
```
Primary         #3182F6   토스 블루, CTA·강조·링크
PrimaryContainer #E8F3FF   선택 상태 배경, 하이라이트
Background      #F9FAFB   전체 배경 (Toss off-white)
Surface         #FFFFFF   카드·시트 배경
SurfaceVariant  #F2F4F6   입력 필드 배경, 구분 영역
```

#### Text (Grayscale — Toss Gray 900/700/500/400)
```
TextPrimary     #191F28   제목, 본문            (Gray 900)
TextSecondary   #4E5968   보조 텍스트·부제목    (Gray 700)
TextTertiary    #8B95A1   캡션·플레이스홀더     (Gray 500)
TextDisabled    #B0B8C1   비활성 텍스트         (Gray 400)
TextOnColor     #FFFFFF   컬러 배경 위 텍스트
```

#### Border
```
Border          #E5E8EB   일반 테두리
BorderLight     #F2F4F6   구분선, 약한 테두리
BorderFocus     #3182F6   포커스 링
```

#### Shift Type Colors (핵심)
```
오전   text: #3182F6  bg: #E8F3FF
오후   text: #FF9A3C  bg: #FFF4E6
야간   text: #6C5CE7  bg: #F0EDFF
휴무   text: #8B95A1  bg: #F2F4F6
이브닝 text: #1EC772  bg: #E6F9F0
```

#### Semantic Colors (Toss palette)
```
Success   #1EC772   제출 완료, 100% 달성
Warning   #FF9A3C   진행 중, 주의
Error     #F04452   에러, 초과, 일요일
```

#### Calendar Colors
```
Sunday      #F04452   일요일 텍스트
Saturday    #3182F6   토요일 텍스트
CellHover   #F9FAFB   셀 호버 배경
```

#### Dark Mode
```
Surface         #17171C
Background      #111113
OnSurface       #F9FAFB
OnSurfaceVariant #8B95A1
Outline         #2E3038
OutlineVariant  #1F2028
PrimaryContainer #0E2E56
```

### 2.4 타이포그래피

**기본 폰트**: Pretendard (웹폰트)

| 토큰 | 크기 | 굵기 | 행간 | 용도 |
|------|------|------|------|------|
| `displayLarge` | 24px | Bold (700) | 1.3 | 화면 제목 |
| `titleMedium` | 16px | SemiBold (600) | 1.4 | 섹션 제목, 카드 타이틀 |
| `titleSmall` | 14px | SemiBold (600) | 1.4 | 소제목 |
| `bodyMedium` | 14px | Regular (400) | 1.5 | 본문 |
| `bodySmall` | 12px | Regular (400) | 1.5 | 보조 텍스트 |
| `labelLarge` | 12px | Bold (700) | 1.3 | 버튼 텍스트 |
| `labelSmall` | 10px | SemiBold (600) | 1.3 | 하단 탭 라벨, 캡션 |
| `calendarDay` | 12px | Medium (500) | - | 캘린더 날짜 숫자 |
| `shiftBadge` | 9px | Bold (700) | - | 근무타입 뱃지 텍스트 |

### 2.5 스페이싱 & 레이아웃

**기본 그리드**: 4px 단위

| 토큰 | 값 | 용도 |
|------|-----|------|
| `xs` | 4px | 아이콘-텍스트 간격 |
| `sm` | 8px | 컴포넌트 내부 여백 |
| `md` | 12px | 버튼 세로 패딩, 입력 패딩 |
| `lg` | 16px | 카드 패딩, 섹션 간격 |
| `xl` | 20px | 버튼 가로 패딩 |
| `xxl` | 24px | 대 섹션 간격 |
| `xxxl` | 32px | 화면 레벨 여백 |

#### 캘린더 셀
```
Mobile Cell Height   60px
Tablet Cell Height   80px
Cell Gap              1px
Cell Padding          4px
Cell Border Radius    0px (TimeTree 스타일 격자)
```

#### 컴포넌트 Radius
```
Card              16px
Card Large        24px
Bottom Sheet      24px (상단만)
Input             12px
Button            12px
```

### 2.6 그림자 (Elevation)

기본적으로 **elevation: 0** (토스 스타일 flat 디자인). 필요 시:

| 토큰 | Offset | Blur | 용도 |
|------|--------|------|------|
| `sm` | (0, 1) | 2px | 미세한 구분 |
| `md` | (0, 2) | 8px | 떠있는 카드 |
| `lg` | (0, 8) | 25px | 바텀시트, 모달 |
| `focus` | (0, 0) | spread: 2px | 포커스 링 (Primary 20%) |

### 2.7 컴포넌트 스타일 가이드

#### 카드
- `elevation: 0`, `borderRadius: 16px`, 배경 `Surface`
- 구분은 `BorderLight` 또는 `SurfaceVariant` 배경으로

#### 바텀시트
- 상단 `borderRadius: 24px`, 드래그 핸들 표시
- 폼 바텀시트: 타이틀 + 입력 필드 + CTA 버튼

#### 뱃지 (ShiftBadge)
- 크기: 약어에 따라 가변, 최소 터치 영역 확보
- 텍스트: `shiftBadge` (9px Bold), 배경: shift color bg, 텍스트: shift color

#### 버튼
- Primary: `Primary` 배경 + white 텍스트
- `borderRadius: 12px`, `elevation: 0`
- 패딩: 가로 20px, 세로 12px
- 비활성 시 opacity 감소

#### 네비게이션 바
- 높이: 64px
- 상단 `BorderLight` 0.5px 구분선
- 선택 인디케이터: `PrimaryContainer`
- 3탭: 홈(home) / 근무신청(edit_calendar) / 설정(settings)

### 2.8 인터랙션 패턴

#### Paint Mode
- 근무타입 선택 → 날짜 셀 탭 → 즉시 배정 (< 100ms 반응)
- 같은 타입 재탭 → 토글 해제
- 지우기 모드: 탭하여 배정 삭제
- 선택된 타입: ring + scale 강조

#### 애니메이션
- 화면 전환: Material 3 기본 트랜지션
- 상태 변경: 부드러운 색상 전환 (200ms)
- 프로그레스 바: 애니메이션 fill

#### 햅틱
- Paint Mode 배정/해제 시 경미한 햅틱 피드백 (선택)

### 2.9 접근성 기준

- **최소 터치 타겟**: 44×44dp
- **색상 + 텍스트**: 색상만으로 정보 전달하지 않음 (근무타입 약어 병행)
- **다크 모드**: 완전 지원 (Dark ColorScheme 정의)
- **폰트 스케일링**: 시스템 설정 존중

---

## 3. 기술 스택

### 3.1 Frontend (Web App)
| 항목 | 기술 | 비고 |
|------|------|------|
| Framework | Next.js 15 (App Router) | React 19, TypeScript |
| State (서버) | TanStack Query v5 | API 캐싱, 오프라인 지원 |
| State (클라이언트) | Zustand | 경량 클라이언트 상태 (Paint Mode 등) |
| Styling | Tailwind CSS v4 + shadcn/ui | 토스 스타일 미니멀 UI |
| Form | React Hook Form + Zod | 바텀시트 폼 검증 |
| HTTP | Axios | JWT 인터셉터, refresh 자동 처리 |
| Font | Pretendard (웹폰트) | |
| PWA | next-pwa | 홈 화면 추가, 오프라인 캐시 |
| Calendar | CSS Grid 직접 구현 | Paint Mode 커스텀 인터랙션 |
| Architecture | Feature-First (App Router 기반) | |

### 3.2 Backend
| 항목 | 기술 | 비고 |
|------|------|------|
| Framework | Spring Boot 3.x | Java 21 |
| Auth | JWT + Google OAuth 2.0 | Access (1h) + Refresh (7d) |
| Security | Spring Security | Stateless, Role-based |
| DB Migration | Flyway | `baseline-on-migrate: true` |
| API Docs | SpringDoc OpenAPI 3.0 | Swagger UI |

### 3.3 Database
| 항목 | 기술 | 비고 |
|------|------|------|
| Production | PostgreSQL 16 | Docker compose |
| Port | 5433 (host) → 5432 (container) | |

### 3.4 Infrastructure
| 항목 | 기술 | 비고 |
|------|------|------|
| Container | Docker + docker-compose | 백엔드 + DB |
| Frontend 배포 | Vercel 또는 Docker | |
| Push | Web Push API (예정) | |

---

## 4. 사용자 역할 & 권한 매트릭스

| 기능 | Worker | Manager | Admin |
|------|--------|---------|-------|
| 공유 캘린더 조회 (월간/주간) | ✅ | ✅ | ✅ |
| 본인 스케줄 입력 (Paint Mode) | ✅ | - | - |
| 본인 스케줄 제출 | ✅ | - | - |
| 팀 스케줄 조회 | - | ✅ | ✅ |
| 스케줄 승인/반려 | - | ✅ | ✅ |
| 근무타입 CRUD | - | ✅ | ✅ |
| 휴가 MAX 관리 | - | ✅ | ✅ |
| 이벤트 CRUD | - | ✅ | ✅ |
| 조직/사용자 관리 | - | - | ✅ (미구현) |

**API 보안 적용**:
- `/api/auth/**`, `/api/branches`, `/api/dev/**` → 인증 불요
- `/api/schedules/**` → 인증 필요 (Worker)
- `/api/manager/**` → `MANAGER` 또는 `ADMIN` role 필요
- `/api/branch/calendar/**` → 인증 필요 (모든 role)

---

## 5. 네비게이션 구조

### 5.1 하단 탭

```
┌─────────────────────────────────────────────┐
│           BottomNavigationBar (64px)         │
├─────────────┬───────────────┬───────────────┤
│  🏠 홈      │ 📝 근무신청   │ ⚙️ 설정       │
│  /home      │  /schedule    │  /settings    │
└─────────────┴───────────────┴───────────────┘
```

### 5.2 전체 라우트 맵

```
/home                              → 공유 캘린더 (월간/주간)
  └ [바텀시트] 날짜 상세

/schedule                          → 근무신청 (Paint Mode)

/settings                          → 설정 허브
  ├ /settings/shift-types          → 근무타입 관리
  │   └ [바텀시트] 추가/수정
  ├ /settings/vacation             → 휴가 MAX 설정
  ├ /settings/events               → 이벤트 관리
  │   └ [바텀시트] 추가/수정
  ├ /settings/team-calendar        → 팀 캘린더
  │   └ /settings/team-calendar/[memberId] → 팀원 스케줄 상세
  └ (미구현: 프로필, 알림 설정)
```

**설정 하위 라우트**: 하단 네비 숨김, 뒤로가기(← 버튼) 지원

---

## 6. 화면별 상세 스펙

### 6.1 공유 캘린더 — 월간 뷰

**라우트**: `/home` (기본 탭)
**컴포넌트**: `SharedCalendar`

```
┌─────────────────────────────────────┐
│  AppBar: "캘린더"  [월간|주간] 토글  │
├─────────────────────────────────────┤
│  ◀  2026년 3월  ▶                  │  ← 월 네비게이션
├─────────────────────────────────────┤
│  일   월   화   수   목   금   토   │  ← 요일 헤더
├─────────────────────────────────────┤
│  1          2          3     ...   │
│  오전:3     오후:2     야간:1       │  ← 근무타입별 인원 수 요약
│  📌안전교육                         │  ← 이벤트 칩
│  ...                               │
│  28   29   30   31                 │
├─────────────────────────────────────┤
│  [날짜 탭 → 상세 바텀시트]          │
└─────────────────────────────────────┘
```

**인터랙션**:
- 좌우 화살표: 이전/다음 월 이동
- `[월간|주간]` 토글: 뷰 전환
- 날짜 셀 탭 → `DayDetailSheet` (근무그룹별 인원 + 이름)
- 오늘 날짜: 파란색 링 강조

**날짜 셀 (월간)**:
- 날짜 숫자 (일=빨강, 토=파랑, 평일=기본)
- 근무타입별 인원수: `오전:3  오후:2` 형식 (ShiftBadge)
- 이벤트 칩 (있을 경우)

**상태**:
```typescript
interface SharedCalendarState {
  year: number
  month: number
  viewMode: 'monthly' | 'weekly'
  daySummaries: Record<number, DayShiftSummary>  // day → {shiftCounts, totalMembers}
  events: EventInfo[]
}
```

**Semantics Labels**: `prev-month`, `next-month`, `view-monthly`, `view-weekly`

---

### 6.2 공유 캘린더 — 주간 뷰

**라우트**: `/home` (주간 탭 선택 시)

```
┌─────────────────────────────────────┐
│  AppBar: "캘린더"  [월간|주간]       │
├─────────────────────────────────────┤
│  ◀  3월 1주  ▶                     │
├───────┬────┬────┬────┬────┬────┬───┤
│       │ 월 │ 화 │ 수 │ 목 │ 금 │토 │
│ 이름  │ 1  │ 2  │ 3  │ 4  │ 5  │ 6│
├───────┼────┼────┼────┼────┼────┼───┤
│김민수 │오전│오전│오후│야간│야간│휴무│
│이서연 │오후│오후│오전│오전│휴무│오전│
│박지훈 │야간│휴무│야간│오후│오전│오후│
└───────┴────┴────┴────┴────┴────┴───┘
```

**인터랙션**:
- 좌우 스와이프/화살표: 주 이동
- 행: 팀원, 열: 요일 (7일)
- 셀: `ShiftBadge` (약어 + 컬러)

**API**: `GET /api/branch/calendar/weekly?year=&month=&weekStart=`

---

### 6.3 공유 캘린더 — 날짜 상세 (바텀시트)

**표시 방식**: 날짜 셀 탭 시 `BottomSheet`

```
┌─────────────────────────────────┐
│  ──── (drag handle)             │
│  3월 15일 (수) 근무 현황         │
├─────────────────────────────────┤
│  🔵 오전  3명                   │
│    김민수, 이서연, 박지훈         │
├─────────────────────────────────┤
│  🟠 오후  2명                   │
│    최수영, 정하늘                 │
├─────────────────────────────────┤
│  🟣 야간  1명                   │
│    한도윤                        │
├─────────────────────────────────┤
│  📌 이벤트: 안전교육             │
└─────────────────────────────────┘
```

---

### 6.4 근무신청 — Paint OFF 상태

**라우트**: `/schedule`
**컴포넌트**: `WorkerCalendar`

```
┌─────────────────────────────────┐
│  AppBar: "근무신청"              │
├─────────────────────────────────┤
│  ◀  2026년 3월  ▶              │
├─────────────────────────────────┤
│  일  월  화  수  목  금  토      │
├─────────────────────────────────┤
│  [1] [2] [3] [4] [5] [6] [7]  │
│  (빈 셀들)                      │
│  ...                            │
├─────────────────────────────────┤
│  작성 현황: 0/31일  ░░░░░ 0%   │
│                  [등록하기]      │  ← Paint Mode 활성화 버튼
└─────────────────────────────────┘
```

**인터랙션**:
- `[등록하기]` 탭 → Paint Mode ON 전환
- 캘린더 조회만 가능 (날짜 탭 비활성)

---

### 6.5 근무신청 — Paint ON 상태

```
┌─────────────────────────────────────┐
│  AppBar: "근무신청"     [Paint ON]  │
├─────────────────────────────────────┤
│  ◀  2026년 3월  ▶                  │
├─────────────────────────────────────┤
│  일  월  화  수  목  금  토         │
├─────────────────────────────────────┤
│  [1]  [2]  [3]  [4]  [5]  [6]  [7]│
│  오전      야간 휴무 오전      오후 │  ← ShiftBadge 배정됨
│  (배정된 셀: shift 배경색 40%)      │
│  ...                               │
├─────────────────────────────────────┤
│  ┌─ Paint Toolbar ───────────────┐ │
│  │ ● 오전 ● 오후 ● 야간 ● 휴무 🧹│ │  ← 근무타입 원형 버튼 + 지우기
│  └───────────────────────────────┘ │
├─────────────────────────────────────┤
│  작성 현황: 23/31일  ▓▓▓▓░ 74%    │
│                      [제출하기]     │  ← 100% 시 활성화
└─────────────────────────────────────┘
```

**핵심 인터랙션: Paint Mode**
1. **Paint Toolbar**에서 근무타입 하나를 선택 (선택된 타입: ring + scale 강조)
2. 캘린더 날짜 셀을 **탭** → 선택된 근무타입 배정
3. 이미 같은 타입이 배정된 날짜를 **재탭** → 배정 해제 (토글)
4. **지우기(🧹)** 선택 후 탭 → 기존 배정 삭제
5. **Paint OFF 토글** → 조회 전용 모드

**날짜 셀 구조**:
- 좌상단: 날짜 숫자 (일=빨강, 토=파랑)
- 우상단: ShiftBadge (약어 + 배경색)
- 배정된 셀: 해당 shift 배경색 (opacity 40%)
- 오늘 날짜: 파란색 ring

**Submit Bar**:
- Progress: `{배정 일수}/{월 총 일수}일` + 퍼센트 바
- 바 색상: <50% 주황, 50~99% 파랑, 100% 초록
- 제출 버튼: **100% 완료 시에만 활성화**

**상태**:
```typescript
interface CalendarState {
  year: number
  month: number
  assignments: Record<number, ShiftType>  // day → shift type
  paintMode: boolean
  selectedShiftType: ShiftType | null
  submissionStatus: 'DRAFT' | 'SUBMITTED'
}
```

**Semantics Labels**: `paint-mode-toggle`, `shift-btn-{오전|오후|야간|휴무}`, `eraser-btn`, `day-cell-{day}`, `submit-button`, `prev-month-worker`, `next-month-worker`

---

### 6.6 근무신청 — 제출 완료 상태

```
┌─────────────────────────────────────┐
│  AppBar: "근무신청"                  │
├─────────────────────────────────────┤
│  (캘린더: 모든 날짜 배정 표시)       │
│  (수정 불가 — 읽기 전용)             │
├─────────────────────────────────────┤
│  ✅ 제출 완료                        │
│  제출일: 2026-03-15 14:30           │
│  작성 현황: 31/31일  ▓▓▓▓▓ 100%    │
└─────────────────────────────────────┘
```

**동작**:
- 제출 후 수정 불가
- 수정 필요 시: 매니저에게 반려 요청 → 매니저 반려 시 DRAFT로 돌아가 재작성

---

### 6.7 설정 허브

**라우트**: `/settings`
**컴포넌트**: `SettingsHub`

```
┌─────────────────────────────────┐
│  AppBar: "설정"                  │
├─────────────────────────────────┤
│  ┌────────────────────────────┐ │
│  │ 📋 팀 캘린더              →│ │  ← /settings/team-calendar
│  ├────────────────────────────┤ │
│  │ 📝 근무타입 관리          →│ │  ← /settings/shift-types
│  ├────────────────────────────┤ │
│  │ 🏖️ 휴가 MAX 설정         →│ │  ← /settings/vacation
│  ├────────────────────────────┤ │
│  │ 📅 이벤트 관리            →│ │  ← /settings/events
│  └────────────────────────────┘ │
│                                 │
│  (향후: 프로필, 알림 설정 등)    │
└─────────────────────────────────┘
```

**Semantics Labels**: `settings-{title}` (각 메뉴 항목)

---

### 6.8 근무타입 관리

**라우트**: `/settings/shift-types` (push)
**컴포넌트**: `ShiftTypes`

```
┌─────────────────────────────────────┐
│  ← 근무타입 관리            [+ 추가]│
├─────────────────────────────────────┤
│  [전체] [활성] [비활성]  ← 필터 탭  │
├─────────────────────────────────────┤
│  ☰  🔵 오전  오전 근무  09:00-18:00│  ← 드래그 핸들 + 뱃지 + 정보
│  ☰  🟠 오후  오후 근무  14:00-22:00│
│  ☰  🟣 야간  야간 근무  22:00-07:00│
│  ☰  ⚪ 휴무  휴무                  │
└─────────────────────────────────────┘
```

**CRUD 기능**:
- **생성**: [+ 추가] → `ShiftTypeFormDialog` 바텀시트
  - 필드: 이름, 약어(1~5자), 색상, 배경색, 카테고리, 시작/종료 시간
- **수정**: 항목 탭 → 같은 바텀시트 (수정 모드)
- **삭제**: Soft delete (isActive → false)
- **순서 변경**: 드래그&드롭 → `PUT /api/manager/shift-types/reorder`
- **필터**: 전체/활성/비활성 (`?status=all|active|inactive`)

**기본 제공 타입**:

| 약어 | 이름 | 카테고리 | 색상 | 시간 |
|------|------|----------|------|------|
| 오전 | 오전 근무 | WORK | #3182F6 | 09:00-18:00 |
| 오후 | 오후 근무 | WORK | #FF9A3C | 14:00-22:00 |
| 야간 | 야간 근무 | WORK | #6C5CE7 | 22:00-07:00 |
| 휴무 | 휴무 | OFF | #8B95A1 | - |

---

### 6.9 근무타입 추가/수정 폼 (바텀시트)

```
┌─────────────────────────────────┐
│  ──── (drag handle)             │
│  근무타입 추가                   │
├─────────────────────────────────┤
│  이름     [__________________]  │
│  약어     [___] (1~5자)         │
│  카테고리  [WORK ▾]             │
│  색상     [🟦 선택]             │
│  배경색   [🟦 선택]             │
│  시작시간 [09:00]               │
│  종료시간 [18:00]               │
├─────────────────────────────────┤
│         [저장하기]               │
└─────────────────────────────────┘
```

---

### 6.10 휴가 MAX 설정

**라우트**: `/settings/vacation` (push)
**컴포넌트**: `VacationSettings`

```
┌─────────────────────────────────────┐
│  ← 휴가 MAX 설정                    │
├─────────────────────────────────────┤
│  기본 일일 최대 인원                  │
│  [ − ]  3명  [ + ]   ← Stepper UI  │
├─────────────────────────────────────┤
│  날짜별 예외 설정                     │
│  [+ 예외 추가]                       │
├─────────────────────────────────────┤
│  3/15  5명  [×]                     │
│  3/22  2명  [×]                     │
│  3/25  0명  [×]   ← override chips  │
└─────────────────────────────────────┘
```

**기능**:
- **기본 MAX**: Stepper (−/숫자/+) → `PUT /api/manager/vacation-limits`
- **날짜별 Override**: 날짜 선택 → MAX 조정 → `POST /api/manager/vacation-limits/overrides`
- **Override 삭제**: chip의 [×] → `DELETE /api/manager/vacation-limits/overrides/{id}`
- 캘린더에 실시간 반영: 해당 일자 셀에 `{현재}/{조정된 MAX}` (MAX 도달 시 빨간색)

---

### 6.11 이벤트 관리

**라우트**: `/settings/events` (push)
**컴포넌트**: `Events`

```
┌─────────────────────────────────────┐
│  ← 이벤트 관리             [+ 추가] │
├─────────────────────────────────────┤
│  🔍 [검색어 입력...]                │
├─────────────────────────────────────┤
│  ┌─────────────────────────────┐   │
│  │ 🔴 안전교육                  │   │
│  │ 3/15 (수)                   │   │
│  │ 전 직원 필수 참석             │   │
│  └─────────────────────────────┘   │
│  ┌─────────────────────────────┐   │
│  │ 🟢 워크숍                    │   │
│  │ 3/20~3/21                   │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

**CRUD**:
- **검색**: `GET /api/manager/events?q=검색어` (제목 검색)
- **생성**: [+ 추가] → `EventFormDialog` 바텀시트
  - 필드: 제목, 시작일, 종료일, 색상, 메모
- **수정**: 카드 탭 → 같은 바텀시트 (수정 모드)
- **삭제**: 바텀시트 내 삭제 버튼

---

### 6.12 팀 캘린더 (매니저)

**라우트**: `/settings/team-calendar` (push)
**컴포넌트**: `ManagerCalendar`

```
┌─────────────────────────────────────┐
│  ← 팀 캘린더       [월간|주간]       │
├─────────────────────────────────────┤
│  ◀  2026년 3월  ▶                  │
├─────────────────────────────────────┤
│  (월간 캘린더: 이벤트 + 휴가 현황)   │
│  날짜 셀: 이벤트칩 + V:{현재}/{MAX}  │
├─────────────────────────────────────┤
│  ┌── 팀원 현황 ──────────────────┐ │
│  │ 🟦 김민수  ✅ 제출 완료        │ │  ← 탭 → member schedule
│  │ 🟪 이서연  🔄 작성중 73%      │ │
│  │ 🟩 박지훈  🔄 작성중 45%      │ │
│  │ ⬜ 최수영  ⬜ 미작성           │ │
│  └────────────────────────────────┘ │
└─────────────────────────────────────┘
```

**인터랙션**:
- 팀원 카드 탭 → `/settings/team-calendar/member` (개별 스케줄 상세)
- 월간/주간 토글
- 날짜 탭 → 해당 일자 전체 팀원 배정 상세 바텀시트

**API**: `GET /api/manager/team/schedules?year=&month=`

---

### 6.13 팀원 스케줄 상세

**라우트**: `/settings/team-calendar/member` (push)
**컴포넌트**: `MemberSchedule`

```
┌─────────────────────────────────┐
│  ← 김민수 스케줄                 │
├─────────────────────────────────┤
│  (월별 캘린더 — 읽기 전용)       │
│  각 날짜에 ShiftBadge 표시       │
├─────────────────────────────────┤
│  상태: ✅ 제출 완료              │
│  제출일: 2026-03-15             │
├─────────────────────────────────┤
│  [승인]  [반려]  ← 매니저 액션   │
└─────────────────────────────────┘
```

**파라미터**: `memberId` (URL param), `memberName` (query 또는 서버 조회)

---

## 7. 핵심 유저 플로우

### 7.1 인증 플로우

```
Google 로그인 탭
    ↓
POST /api/auth/google (idToken)
    ↓
┌─ 기존 유저? ─────────────────┐
│  YES → AuthResponse 반환     │
│        (accessToken,         │
│         refreshToken, user)  │
│        → /home 이동          │
├──────────────────────────────┤
│  NO → {needsRegistration:   │
│        true} 반환            │
│        → 회원가입 화면        │
│        이름 + 지점 선택       │
│        POST /api/auth/       │
│        register              │
│        → /home 이동          │
└──────────────────────────────┘
```

- JWT Access Token: 1시간 유효
- Refresh Token: 7일 유효
- `POST /api/auth/refresh` → 토큰 갱신
- `GET /api/auth/me` → 현재 사용자 정보 (Bearer Token 필요)
- dev 프로파일: `POST /api/dev/token` → 테스트 토큰 발급

### 7.2 스케줄 제출 플로우

```
DRAFT (작성중)
    ↓ Paint Mode로 31일 배정
    ↓ PUT /api/schedules/{year}/{month}/assignments (auto-save)
    ↓ 100% 완료
SUBMITTED (제출됨)
    ↓ POST /api/schedules/{year}/{month}/submit
    ↓ 매니저 검토
APPROVED (승인) 또는 REJECTED (반려)
    ↓ 반려 시 → DRAFT로 복귀, 재작성 가능
```

**제약 사항**:
- 31일 모두 배정 완료 시에만 제출 가능
- 제출 후 수정 불가
- 반려 시에만 재작성 가능

### 7.3 매니저 관리 플로우

```
설정 허브 → 팀 캘린더
    ↓
팀원 현황 카드 (제출 상태 확인)
    ↓
팀원 탭 → 개별 스케줄 상세
    ↓
[승인] 또는 [반려] 액션
```

---

## 8. 데이터 모델

### 8.1 Entity 관계도

```
Branch (지점)
  ├── 1:N → User
  ├── 1:N → ShiftType
  ├── 1:N → CalendarEvent
  └── 1:1 → VacationLimit
               └── 1:N → VacationLimitOverride

User (사용자)
  └── 1:N → MonthlySchedule
               └── 1:N → DailyAssignment
                            └── N:1 → ShiftType
```

### 8.2 Entity 상세

#### Branch
```
Branch {
  id:         UUID        @GeneratedValue
  name:       String      max 100
  code:       String      unique, max 50
  isActive:   boolean     default true
  createdAt:  DateTime    immutable
}
```

#### User
```
User {
  id:              UUID        @GeneratedValue
  email:           String      unique, @NotNull
  name:            String      max 100
  googleId:        String      unique, @NotNull
  profileImageUrl: String?     max 500
  role:            Role        ADMIN | MANAGER | WORKER (default WORKER)
  branch:          Branch      @ManyToOne
  createdAt:       DateTime    immutable
}
```

#### ShiftType
```
ShiftType {
  id:           UUID            @GeneratedValue
  branch:       Branch          @ManyToOne
  name:         String          @NotBlank, max 50
  abbreviation: String          @NotBlank, 1~5자
  color:        String          @NotBlank, max 10 (hex)
  bgColor:      String          @NotBlank, max 10 (hex)
  category:     ShiftCategory   WORK | OFF | VACATION | TRAINING
  sortOrder:    int             default 0
  startTime:    String?         "HH:mm" (5자)
  endTime:      String?         "HH:mm" (5자)
  isActive:     boolean         default true
  createdAt:    DateTime        immutable
}
```

#### MonthlySchedule
```
MonthlySchedule {
  id:           UUID                @GeneratedValue
  user:         User                @ManyToOne, @NotNull
  year:         int                 @NotNull
  month:        int                 @NotNull (1~12)
  status:       SubmissionStatus    DRAFT | SUBMITTED (default DRAFT)
  submittedAt:  DateTime?
  reviewedAt:   DateTime?
  reviewedBy:   User?               @ManyToOne
  createdAt:    DateTime            immutable
  assignments:  List<DailyAssignment>  cascade ALL, orphanRemoval

  UNIQUE(user_id, year, month)
}
```

#### DailyAssignment
```
DailyAssignment {
  id:         UUID        @GeneratedValue
  schedule:   MonthlySchedule  @ManyToOne, @NotNull
  day:        int              @NotNull (1~31)
  shiftType:  ShiftType        @ManyToOne, @NotNull

  UNIQUE(schedule_id, day)
}
```

#### VacationLimit
```
VacationLimit {
  id:          UUID        @GeneratedValue
  branch:      Branch      @OneToOne, unique
  defaultMax:  int         default 3
  overrides:   List<VacationLimitOverride>  cascade ALL, orphanRemoval
}
```

#### VacationLimitOverride
```
VacationLimitOverride {
  id:             UUID          @GeneratedValue
  vacationLimit:  VacationLimit @ManyToOne
  targetDate:     LocalDate     @NotNull
  maxCount:       int

  UNIQUE(vacation_limit_id, target_date)
}
```

#### CalendarEvent
```
CalendarEvent {
  id:         UUID        @GeneratedValue
  branch:     Branch      @ManyToOne
  title:      String      @NotBlank, max 200
  startDate:  LocalDate   @NotNull
  endDate:    LocalDate   @NotNull
  color:      String      @NotNull, max 10 (hex)
  memo:       String?     TEXT
  createdAt:  DateTime    immutable
}
```

### 8.3 Enums

```
Role:             ADMIN, MANAGER, WORKER
ShiftCategory:    WORK, OFF, VACATION, TRAINING
SubmissionStatus: DRAFT, SUBMITTED
```

---

## 9. API 엔드포인트

### 9.1 인증 (`/api/auth`)

| Method | Path | Auth | Request | Response |
|--------|------|------|---------|----------|
| POST | `/api/auth/google` | - | `{idToken}` | `AuthResponse` 또는 `{needsRegistration: true}` |
| POST | `/api/auth/register` | - | `{idToken, name, branchId}` | `AuthResponse` |
| POST | `/api/auth/refresh` | - | `{refreshToken}` | `AuthResponse` |
| GET | `/api/auth/me` | Bearer | - | `UserInfo` |

**AuthResponse**:
```json
{
  "accessToken": "jwt...",
  "refreshToken": "jwt...",
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "name": "김민수",
    "role": "WORKER",
    "profileImageUrl": "https://...",
    "branch": { "id": "uuid", "name": "삼성 강북점" }
  }
}
```

### 9.2 지점 (`/api/branches`)

| Method | Path | Auth | Response |
|--------|------|------|----------|
| GET | `/api/branches` | - | `List<Branch>` (활성 지점 목록) |

### 9.3 근무자 스케줄 (`/api/schedules`)

| Method | Path | Auth | Request | Response |
|--------|------|------|---------|----------|
| GET | `/api/schedules/{year}/{month}` | Bearer | - | `ScheduleResponse` |
| PUT | `/api/schedules/{year}/{month}/assignments` | Bearer | `{assignments: {1: "uuid", 2: "uuid", ...}}` | `ScheduleResponse` |
| POST | `/api/schedules/{year}/{month}/submit` | Bearer | - | `ScheduleResponse` |

**ScheduleResponse**:
```json
{
  "id": "uuid",
  "year": 2026,
  "month": 3,
  "status": "DRAFT",
  "submittedAt": null,
  "assignments": {
    "1": {
      "shiftTypeId": "uuid",
      "shiftTypeName": "오전 근무",
      "abbreviation": "오전",
      "color": "#0064FF",
      "bgColor": "#E8F0FE"
    },
    "2": { ... }
  }
}
```

### 9.4 공유 캘린더 (`/api/branch/calendar`)

| Method | Path | Auth | Query | Response |
|--------|------|------|-------|----------|
| GET | `/api/branch/calendar/monthly` | Bearer | `year`, `month` | `SharedCalendarMonthlyResponse` |
| GET | `/api/branch/calendar/weekly` | Bearer | `year`, `month`, `weekStart` | `SharedCalendarWeeklyResponse` |

**SharedCalendarMonthlyResponse**:
```json
{
  "year": 2026,
  "month": 3,
  "daySummaries": {
    "1": {
      "shiftCounts": {
        "오전": { "count": 3, "color": "#0064FF", "bgColor": "#E8F0FE" },
        "오후": { "count": 2, "color": "#FF9100", "bgColor": "#FFF3E0" }
      },
      "totalMembers": 10,
      "submittedCount": 7
    }
  },
  "events": [
    {
      "id": "uuid",
      "title": "안전교육",
      "startDate": "2026-03-15",
      "endDate": "2026-03-15",
      "color": "#FF3B30",
      "memo": "전 직원 필수"
    }
  ]
}
```

**SharedCalendarWeeklyResponse**:
```json
{
  "year": 2026,
  "month": 3,
  "weekStartDay": 1,
  "members": [
    {
      "userId": "uuid",
      "userName": "김민수",
      "profileImageUrl": "https://...",
      "assignments": {
        "1": { "abbreviation": "오전", "name": "오전 근무", "color": "#0064FF", "bgColor": "#E8F0FE" },
        "2": { ... }
      }
    }
  ],
  "events": [ ... ]
}
```

### 9.5 매니저 — 팀 스케줄 (`/api/manager`)

| Method | Path | Auth | Query | Response |
|--------|------|------|-------|----------|
| GET | `/api/manager/team/schedules` | MANAGER/ADMIN | `year`, `month` | `List<TeamScheduleResponse>` |

**TeamScheduleResponse**:
```json
{
  "scheduleId": "uuid",
  "userId": "uuid",
  "userName": "김민수",
  "profileImageUrl": "https://...",
  "status": "SUBMITTED",
  "assignments": { ... }
}
```

### 9.6 근무타입 CRUD (`/api/manager/shift-types`)

| Method | Path | Auth | Request/Query | Response |
|--------|------|------|---------------|----------|
| GET | `/api/manager/shift-types` | MANAGER/ADMIN | `?status=all\|active\|inactive` | `List<ShiftType>` |
| POST | `/api/manager/shift-types` | MANAGER/ADMIN | `ShiftType` body | `ShiftType` |
| PUT | `/api/manager/shift-types/{id}` | MANAGER/ADMIN | `ShiftType` body | `ShiftType` |
| DELETE | `/api/manager/shift-types/{id}` | MANAGER/ADMIN | - | `void` (soft delete) |
| PUT | `/api/manager/shift-types/reorder` | MANAGER/ADMIN | `List<UUID>` body | `void` |

### 9.7 이벤트 CRUD (`/api/manager/events`)

| Method | Path | Auth | Request/Query | Response |
|--------|------|------|---------------|----------|
| GET | `/api/manager/events` | MANAGER/ADMIN | `?q=검색어` (optional) | `List<CalendarEvent>` |
| POST | `/api/manager/events` | MANAGER/ADMIN | `CalendarEvent` body | `CalendarEvent` |
| PUT | `/api/manager/events/{id}` | MANAGER/ADMIN | `CalendarEvent` body | `CalendarEvent` |
| DELETE | `/api/manager/events/{id}` | MANAGER/ADMIN | - | `void` |

### 9.8 휴가 MAX (`/api/manager/vacation-limits`)

| Method | Path | Auth | Request | Response |
|--------|------|------|---------|----------|
| GET | `/api/manager/vacation-limits` | MANAGER/ADMIN | - | `VacationLimit` (with overrides) |
| PUT | `/api/manager/vacation-limits` | MANAGER/ADMIN | `{defaultMax: int}` | `VacationLimit` |
| POST | `/api/manager/vacation-limits/overrides` | MANAGER/ADMIN | `{date, maxCount}` | `VacationLimit` |
| DELETE | `/api/manager/vacation-limits/overrides/{id}` | MANAGER/ADMIN | - | `void` |

### 9.9 개발 전용

| Method | Path | Auth | 설명 |
|--------|------|------|------|
| POST | `/api/dev/token` | - | dev 프로파일 전용 테스트 토큰 발급 |

---

## 10. 비즈니스 규칙 & 정책

### 10.1 스케줄 제출 규칙
- 월의 모든 날짜(1~28/29/30/31)에 근무타입이 배정되어야 제출 가능 (100%)
- 한 날짜에는 하나의 근무타입만 배정 가능
- 제출 후 수정 불가 — 매니저 반려 시에만 재작성
- 스케줄은 유저+년+월 단위로 유니크 (`UNIQUE(user_id, year, month)`)

### 10.2 근무타입 관리 규칙
- 사용 중인 근무타입 삭제 시 soft delete (isActive → false)
- 근무타입은 지점(Branch) 단위로 관리
- 카테고리: WORK, OFF, VACATION, TRAINING
- 약어: 1~5자 제한

### 10.3 휴가 정책
- 기본 일일 최대 인원: 지점당 설정 (default: 3명)
- 날짜별 Override: 특정 날짜에 한해 MAX 변경 가능 (0명 설정으로 휴가 차단 가능)
- 캘린더에서 실시간 현황 표시: `{현재}/{MAX}` (MAX 도달 시 빨간색)

### 10.4 인증 정책
- Google OAuth 2.0 기반 인증
- JWT Access Token 유효기간: 1시간 (3,600,000ms)
- Refresh Token 유효기간: 7일 (604,800,000ms)
- Stateless 세션 관리

### 10.5 데이터 소속 규칙
- 모든 데이터는 **Branch(지점)** 단위로 격리
- 공유 캘린더는 같은 지점 소속 팀원만 조회 가능
- 매니저는 같은 지점의 팀원 스케줄만 관리 가능

---

## 11. 비기능 요구사항

### 11.1 성능
| 항목 | 목표 |
|------|------|
| 캘린더 화면 초기 로딩 | < 1초 |
| Paint Mode 탭 반응 | < 100ms (즉각적 피드백) |
| 오프라인 지원 | 캘린더 조회 + 배정 입력 가능, 온라인 복귀 시 자동 동기화 |

### 11.2 알림 (예정)
- 스케줄 제출 마감 리마인더
- 스케줄 승인/반려 알림
- 이벤트 리마인더
- Push: FCM (Firebase Cloud Messaging)

### 11.3 보안
- JWT + Refresh Token 인증
- Role 기반 API 접근 제어 (Spring Security `@PreAuthorize`)
- CORS: localhost 패턴 허용 (개발), 프로덕션은 도메인 제한 필요
- Stateless 세션 (STATELESS policy)

### 11.4 접근성
- 최소 터치 타겟: 44×44dp
- 색상만으로 정보 전달하지 않음 (텍스트 약어 병행)
- 다크 모드 지원 (Light/Dark ColorScheme 정의)
- Semantics Labels 정의 (Playwright 테스트 호환)

### 11.5 테스트
- E2E Testing: Playwright
- Unit Test: Vitest
- Component Test: React Testing Library

---

## 부록 A: TypeScript 타입 정의

```typescript
// 사용자
interface AppUser {
  id: string
  email: string
  name: string
  role: 'ADMIN' | 'MANAGER' | 'WORKER'
  profileImageUrl?: string
  branch?: { id: string; name: string }
}

// 근무타입
type ShiftCategory = 'WORK' | 'OFF' | 'VACATION' | 'TRAINING'

interface ShiftType {
  id: string
  name: string
  abbreviation: string       // "오전", "오후", "야간", "휴무"
  color: string              // hex "#0064FF"
  bgColor: string            // hex "#E8F0FE"
  category: ShiftCategory
  sortOrder: number
  isActive: boolean
  startTime?: string         // "HH:mm"
  endTime?: string
}

// 월별 스케줄
type SubmissionStatus = 'DRAFT' | 'SUBMITTED'

interface MonthlySchedule {
  id: string
  year: number
  month: number
  status: SubmissionStatus
  submittedAt?: string       // ISO datetime
  assignments: Record<number, AssignmentInfo>  // day → info
}

interface AssignmentInfo {
  shiftTypeId: string
  shiftTypeName: string
  abbreviation: string
  color: string
  bgColor: string
}

// 캘린더 이벤트
interface CalendarEvent {
  id: string
  title: string
  startDate: string          // "YYYY-MM-DD"
  endDate: string
  color: string
  memo?: string
}

// 휴가 제한
interface VacationLimit {
  id: string
  defaultMax: number
  overrides: VacationOverride[]
}

interface VacationOverride {
  id: string
  targetDate: string         // "YYYY-MM-DD"
  maxCount: number
}

// 공유 캘린더 응답
interface DayShiftSummary {
  shiftCounts: Record<string, { count: number; color: string; bgColor: string }>
  totalMembers: number
  submittedCount: number
}

// 팀 스케줄 응답
interface TeamScheduleResponse {
  scheduleId: string
  userId: string
  userName: string
  profileImageUrl?: string
  status: SubmissionStatus
  assignments: Record<number, AssignmentInfo>
}
```

## 부록 B: 프로젝트 구조

```
frontend/                        # Next.js App
├── src/
│   ├── app/                     # App Router
│   │   ├── (main)/              # 하단 탭 레이아웃 그룹
│   │   │   ├── home/            # 공유 캘린더
│   │   │   ├── schedule/        # 근무신청 (Paint Mode)
│   │   │   ├── settings/        # 설정 허브
│   │   │   └── layout.tsx       # BottomNav 포함 레이아웃
│   │   ├── settings/            # 설정 하위 (탭 없음)
│   │   │   ├── shift-types/
│   │   │   ├── vacation/
│   │   │   ├── events/
│   │   │   └── team-calendar/
│   │   │       └── [memberId]/
│   │   ├── auth/                # 로그인, 회원가입
│   │   └── layout.tsx           # 루트 레이아웃
│   ├── components/
│   │   ├── ui/                  # shadcn/ui 컴포넌트
│   │   ├── calendar/            # MonthlyGrid, WeeklyGrid, DayCell
│   │   ├── paint/               # PaintToolbar, SubmitBar
│   │   └── common/              # ShiftBadge, BottomNav
│   ├── hooks/                   # 커스텀 훅
│   ├── lib/
│   │   ├── api/                 # Axios 인스턴스, API 함수
│   │   └── utils/               # 유틸리티
│   ├── stores/                  # Zustand 스토어
│   └── types/                   # TypeScript 타입 정의
├── public/                      # 정적 에셋
├── tailwind.config.ts
├── next.config.ts
├── package.json
└── tsconfig.json

backend/                         # Spring Boot API (기존 유지)
├── src/main/java/com/clearshift/
│   ├── auth/
│   ├── branch/
│   ├── schedule/
│   ├── shifttype/
│   ├── event/
│   ├── vacation/
│   ├── user/
│   └── config/
└── src/main/resources/
    ├── application.yml
    └── application-dev.yml
```
