# ClearShift - 내 스케줄 (Paint Mode) 디자인 보완 요청

## 앱 정보

"ClearShift" — 교대 근무자용 공유 캘린더 앱
디자인 스타일: Toss(토스) 미니멀 UI
뷰포트: 390x844 (모바일)
레퍼런스 앱: TimeTree, Supershift, My Shift Planner, Nursegrid

---

## 컬러 시스템

- Primary: #0064FF (Toss Blue)
- Background: #FFFFFF
- Surface: #FFFFFF
- SurfaceVariant: #F4F4F5
- TextPrimary: #191F28
- TextSecondary: #8B95A1
- TextTertiary: #B0B8C1
- Border: #E5E8EB
- BorderLight: #F2F4F6
- Success: #00C853
- Warning: #FF9100
- Error: #FF3B30

근무타입 뱃지 색상:
- D 주간: 텍스트 #0064FF / 배경 #E8F0FE
- N 야간: 텍스트 #6C5CE7 / 배경 #F0EDFF
- OFF 휴무: 텍스트 #00B894 / 배경 #E6F9F3
- V 휴가: 텍스트 #FF9100 / 배경 #FFF3E0
- E 교육: 텍스트 #FF3B30 / 배경 #FFEBEE

---

## 하단 네비게이션 바 (4탭, 전체 앱 공통)

레퍼런스 앱 패턴을 참고한 4탭 구성:

탭 1: 홈 (home icon)
- 공유 캘린더 — 팀 전체 스케줄 월간/주간 뷰
- 앱 진입 시 기본 화면

탭 2: 내 근무 (edit calendar icon)
- 내 스케줄 Paint Mode — 근무 신청 화면
- 이 프롬프트의 주요 화면

탭 3: 알림 (bell icon)
- 팀원 스케줄 제출/변경 알림
- 이벤트 알림
- TimeTree의 "활동" 탭, Nursegrid의 "메시지" 탭 참고
- 알림 뱃지 표시 (읽지 않은 알림 수)

탭 4: 더보기 (person icon 또는 ellipsis icon)
- 프로필 정보
- 매니저 전용: 근무타입 관리, 휴가 MAX 설정, 이벤트 관리
- 일반 사용자: 프로필 편집, 알림 설정, 로그아웃
- TimeTree의 "더보기" 탭, My Shift Planner의 설정 패턴 참고

스타일:
- Material 3 NavigationBar
- 상단 0.5px #F2F4F6 구분선
- 활성 탭: #0064FF 아이콘 + 라벨, 연한 파란 indicator
- 비활성 탭: #8B95A1 아이콘 + 라벨
- 높이: 60px (safe area 제외)

---

## 현재 디자인의 문제점 (수정 필요)

### 문제 1: 하단 네비게이션 탭 수가 화면마다 다름
- Paint Mode ON은 5탭, Paint Mode OFF는 4탭으로 불일치
- 올바른 구성: 모든 화면에서 위의 4탭 구조 동일하게 유지
- "내 근무" 탭이 활성(선택된) 상태

### 문제 2: Paint Toolbar 위치
- 현재 디자인: Paint Toolbar가 캘린더 위에 위치
- 올바른 위치: 캘린더 아래에 위치해야 함
- 이유: Supershift, My Shift Planner 모두 캘린더 아래에 근무타입 선택 영역 배치
- 사용자 흐름: 캘린더 확인 → 아래에서 타입 선택 → 캘린더 탭

### 문제 3: Paint Mode 상태별 시각적 차이 부족
- 배정된 셀은 해당 근무타입의 연한 배경색(30% opacity)으로 채워져야 함
- Supershift처럼 셀 안에 컬러 블록이 뚜렷하게 보여야 함

### 문제 4: 프레임 크기 불일치
- Paint Mode OFF: 390x896, Paint Mode ON: 390x884
- 올바른 크기: 390x844 통일

### 문제 5: Submit Bar 스타일
- Paint Mode OFF의 SubmitBar가 어두운 배경(#0F172A)으로 되어 있음
- 올바른 스타일: 흰색 카드 배경 + 1px 보더 (Toss 스타일과 동일)

---

## 디자인할 화면 3개

### 화면 A: 내 스케줄 - Paint Mode OFF (빈 상태)

사용자가 아직 Paint Mode를 켜지 않은 초기 상태.

위에서 아래로:

1. 헤더 바
   - 좌측: "2026년 3월" (22px ExtraBold, #191F28)
   - 우측: 이전 월/다음 월 화살표 버튼 2개 (원형 #F4F4F5 배경)

2. 캘린더 그리드
   - 요일 헤더: 일 월 화 수 목 금 토 (일=빨강, 토=파랑, 나머지=#8B95A1)
   - 7열 그리드, 셀 높이 60px
   - 모든 셀이 비어있음 (배정 없음)
   - 오늘 날짜: 파란 원 안에 흰색 숫자
   - 셀 테두리: 0.5px #F2F4F6

3. Paint Toolbar (캘린더 아래, 카드 형태)
   - 카드: 흰색 배경, 1px #E5E8EB 보더, radius 12px
   - 상단 행: "근무 타입 선택" 라벨(14px SemiBold) + "Paint OFF" 버튼 (회색 pill, #F4F4F5 배경, #8B95A1 텍스트)
   - 하단 행: 5개 근무타입 버튼 + 지우기 버튼 (Wrap, spacing 6px)
     - 모든 버튼 opacity 0.4 (비활성 상태)
     - 각 버튼: 색상 원형 dot(8px) + ShiftBadge pill (stadium shape)
     - D(파랑), N(보라), OFF(초록), V(주황), E(빨강)
     - 지우기: 회색 보더 pill "지우기"

4. Submit Bar (카드 형태)
   - 카드: 흰색 배경, 1px #E5E8EB 보더, radius 12px
   - 좌측: "작성 현황: 0/31일 0%" (14px, #191F28)
   - 우측: 비활성 제출 버튼 (#F4F4F5 배경, "제출하기" #B0B8C1 텍스트, radius 8px)
   - 하단: 프로그레스 바 (6px 높이, full radius, 0% — 전부 #F4F4F5)

5. 범례 (Legend)
   - 가로 Wrap: 각 근무타입 ShiftBadge(SM pill) + 이름 텍스트 (12px)
   - "D 주간", "N 야간", "OFF 휴무", "V 휴가", "E 교육"

6. 하단 네비게이션 바 (4탭: 홈, 내 근무(활성), 알림, 더보기)

---

### 화면 B: 내 스케줄 - Paint Mode ON (60% 작성 중)

사용자가 Paint Mode를 켜고 D(주간)를 선택하여 일부 날짜를 배정한 상태.

위에서 아래로:

1. 헤더 바 (화면 A와 동일)

2. 캘린더 그리드
   - 약 19/31일 배정 완료 (60%)
   - 배정된 셀 시각 표현:
     - 셀 전체 배경: 해당 근무타입 bgColor 30% opacity
       (예: D면 #E8F0FE 30%, N이면 #F0EDFF 30%)
     - 좌상단: 날짜 숫자
     - 우상단: ShiftBadge(SM) pill — "D", "N", "OFF" 등
   - 비어있는 셀: 배경 투명, 날짜 숫자만 표시
   - 예시 배정 데이터 (3월):
     - 1일(일): D, 2일: D, 3일: N, 4일: N, 5일(오늘): D
     - 6일: OFF, 7일: OFF, 8일(일): D, 9일: D, 10일: N
     - 11일: N, 12일: OFF, 13일: OFF, 14일(일): D
     - 15일: D, 16일: N, 17일: N, 18일: OFF, 19일: OFF
     - 20일~31일: 미배정 (빈 셀)
   - 배정된 셀과 빈 셀의 대비가 명확해야 함 (컬러 vs 투명)

3. Paint Toolbar (활성 상태)
   - "Paint ON" 버튼: 파란색 pill (#0064FF 배경, 흰색 텍스트 "Paint ON")
   - D(주간) 버튼이 선택된 상태:
     - D 버튼: scale 1.05, opacity 1.0, 1.5px 파란 테두리 + 미세한 그림자
   - 나머지 N, OFF, V, E 버튼: opacity 0.6 (선택 가능하지만 미선택)
   - 지우기 버튼: opacity 0.6

4. Submit Bar
   - "작성 현황: 19/31일 61%" 텍스트
   - 프로그레스 바: 61%, 파란색 (#0064FF) — 50% 이상이므로
   - 제출 버튼: 비활성 회색 (100% 미달)

5. 범례 (화면 A와 동일)

6. 하단 네비게이션 바 (4탭: 홈, 내 근무(활성), 알림, 더보기)

---

### 화면 C: 내 스케줄 - 제출 완료 (100%)

모든 날짜가 배정되고 제출까지 완료된 상태.

위에서 아래로:

1. 헤더 바 (화면 A와 동일)

2. 캘린더 그리드
   - 31/31일 배정 완료 (100%)
   - 모든 셀에 근무타입 배경색 + ShiftBadge 표시
   - 전체적으로 컬러풀한 패턴이 한눈에 보임
   - 예시 배정 데이터 (3월 전체):
     - 1~5일: D, D, N, N, D
     - 6~7일: OFF, OFF
     - 8~12일: D, D, N, N, OFF
     - 13~14일: OFF, D
     - 15~19일: D, N, N, OFF, OFF
     - 20~21일: D, D
     - 22~26일: N, N, OFF, OFF, D
     - 27~28일: D, V
     - 29~31일: V, OFF, OFF

3. Paint Toolbar
   - "Paint OFF" 상태 (제출 후)
   - 모든 버튼 opacity 0.4

4. Submit Bar (제출 완료 상태)
   - "작성 현황: 31/31일 100%" 텍스트
   - 프로그레스 바: 100%, 초록색 (#00C853)
   - 제출 버튼 대신: 초록색 "제출 완료" 뱃지
     - 초록 연한 배경 (#00C853 10% opacity)
     - 체크 아이콘 + "제출 완료" 텍스트 (#00C853, Bold)

5. 범례 (화면 A와 동일)

6. 하단 네비게이션 바 (4탭: 홈, 내 근무(활성), 알림, 더보기)

---

## Paint Mode 핵심 인터랙션 설명

### 사용 흐름 (Supershift, My Shift Planner 참고)
1. 사용자가 "Paint OFF" 버튼을 탭 → "Paint ON"으로 변경 (회색→파란색)
2. 근무타입 선택 (예: D 주간) → 해당 버튼 강조 (scale up + ring border)
3. 캘린더의 날짜 셀을 탭 → 선택된 근무타입이 배정됨
   - 빈 셀 탭: 선택된 타입으로 배정 (셀 배경색 + ShiftBadge 즉시 표시)
   - 같은 타입 셀 재탭: 배정 해제 (토글)
   - 다른 타입 셀 탭: 타입 교체
4. "지우기" 선택 후 셀 탭: 기존 배정 삭제
5. 매 탭마다 SubmitBar 진행률 실시간 업데이트
6. 100% 달성 시 제출 버튼 활성화 (회색→파란색)
7. 제출 탭 → "제출 완료" 초록 뱃지로 전환
8. 제출 후 수정 필요 시: Paint ON → 수정 → DRAFT로 자동 전환 → 재제출

### 시각 피드백
- 셀 탭 시: scale 0.95 → 1.0 바운스 애니메이션 (100ms)
- 셀 탭 시: haptic feedback (가벼운 진동)
- 배정된 셀: 근무타입 bgColor 30% opacity 전체 배경 + 우상단 ShiftBadge pill
- 프로그레스 바 색상 단계: 주황(0~49%) → 파랑(50~99%) → 초록(100%)
- Paint ON 상태에서 캘린더 영역에 미세한 파란 테두리 또는 glow 효과로 "편집 모드" 표현

---

## 절대 하지 말 것

- 하단 네비게이션 탭 수를 화면마다 다르게 만들지 말 것 (모든 화면 4탭 동일)
- Paint Toolbar를 캘린더 위에 배치하지 말 것 (반드시 캘린더 아래)
- Submit Bar에 어두운 배경색(#0F172A) 사용하지 말 것 (흰색 카드 + 보더)
- Paint Mode OFF일 때 버튼을 완전히 숨기지 말 것 (0.4 opacity로 흐리게 표시)
- 하단 네비게이션에 "설정" 탭을 두지 말 것 ("더보기" 또는 "마이"로 표현)

## 반드시 지킬 것

- 화면 레이아웃 순서: 헤더 → 캘린더 → PaintToolbar → SubmitBar → Legend → BottomNav
- Toss 스타일: 순백 배경, 카드는 그림자 없이 1px 보더, 충분한 여백
- 3개 화면 모두 동일한 레이아웃 구조 — 상태(OFF/ON/Submitted)만 다름
- 배정된 셀의 컬러풀한 배경이 Paint Mode의 핵심 시각 요소
- 프레임 크기: 390x844 통일
- 하단 네비게이션: 4탭 (홈, 내 근무, 알림, 더보기) 고정, "내 근무" 활성 상태
