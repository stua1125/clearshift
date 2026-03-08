# ClearShift - Readdy.ai Design Prompt

## App Overview

Design a mobile app called "ClearShift" — a shift scheduling & shared calendar app for shift workers (nurses, factory workers, retail staff). The app allows workers to paint their monthly schedule and share it with the team in real-time.

- Design Style: Toss (Korean fintech app) clean minimal UI + TimeTree calendar layout
- Color System: Toss Blue (#0064FF) as primary, white (#FFFFFF) background, colorful shift badges
- Typography: Noto Sans KR (or SF Pro), clean and readable
- Platform: Mobile (iOS/Android), 390x844 viewport

---

## Color System

Primary: #0064FF — Main actions, today indicator, Day shift
Background: #FFFFFF — App background
Surface: #FFFFFF — Cards, sheets
SurfaceVariant: #F4F4F5 — Toggle backgrounds, inactive areas
TextPrimary: #191F28 — Main text
TextSecondary: #8B95A1 — Subtitle, helper text
TextTertiary: #B0B8C1 — Placeholder, disabled
Border: #E5E8EB — Card borders
BorderLight: #F2F4F6 — Cell dividers (0.5px)
Success: #00C853 — Submitted status
Warning: #FF9100 — In-progress, Vacation shift
Error: #FF3B30 — Delete, Sunday, Training shift

Shift Badge Colors:
- Day shift: text #0064FF / background #E8F0FE
- Night shift: text #6C5CE7 / background #F0EDFF
- Off-duty: text #00B894 / background #E6F9F3
- Vacation: text #FF9100 / background #FFF3E0
- Training: text #FF3B30 / background #FFEBEE

Calendar Day Colors:
- Sunday text: #FF3B30 (red)
- Saturday text: #0064FF (blue)

---

## Design System Components

### 1. ShiftBadge (Pill Badge)
- Stadium-shaped (fully rounded) pill
- Background: shift type's light bg color (e.g., #E8F0FE for Day)
- Text: shift type's bold color + abbreviation (e.g., "D", "N", "OFF", "V", "T")
- Font: 9px Bold
- Sizes: SM (18px h), MD (22px h), LG (28px h)
- Selected state: 1.5px border in shift color + subtle shadow

### 2. Bottom Navigation Bar (4 tabs, consistent across all screens)
- Tab 1: Home icon + "홈" — shared calendar, team schedule (TimeTree style)
- Tab 2: Edit Calendar icon + "내 근무" — personal schedule paint mode (Supershift style)
- Tab 3: Bell icon + "알림" — team notifications, schedule changes (TimeTree "Activity" style)
  - Notification badge (red dot with count) when unread
- Tab 4: Person icon + "더보기" — profile, manager settings (TimeTree "More" style)
- Material 3 NavigationBar style, no elevation, 0.5px top divider
- Active: #0064FF icon + label, light blue indicator
- Inactive: #8B95A1 icon + label
- Height: 60px

### 3. Month Navigator
- Center: "2026년 3월" (year + month, 22px Bold)
- Left/Right: chevron icon buttons for prev/next month
- Horizontally centered layout

### 4. View Mode Toggle
- Segmented control with 2 options: "월간" / "주간"
- Background: #F4F4F5 rounded container
- Selected: white background with subtle shadow, primary text
- Unselected: transparent, secondary text

---

## Screen 1: Shared Calendar - Monthly View (Main Screen)

Route: First tab, main landing screen
Purpose: View the entire team's schedule at a glance

Layout (top to bottom):
1. Header: App logo "CS" (blue circle) + "ClearShift" text + role badge ("근무자" or "매니저")
2. Month Navigator: < 2026년 3월 >
3. View Mode Toggle: [월간] [주간]
4. Weekday Header Row: 일 월 화 수 목 금 토 (일 in red, 토 in blue)
5. Calendar Grid: 7-column grid, TimeTree-style minimal borders (0.5px #F2F4F6)

SharedDayCell (each cell in the grid):
- Height: 60px
- Top-left: day number (12px Medium, red for Sunday, blue for Saturday)
- Today: day number inside a blue circle (#0064FF) with white text
- Center: mini shift summary badges — "D:3 N:2 OFF:1" format
  - Each mini badge: tiny pill with colored background, 8px Bold text
  - Example: blue bg "D:3", purple bg "N:2", green bg "OFF:1"
- Bottom: event chip (colored dot + event title, 8px, truncated)
- Cell border: 0.5px #F2F4F6 (TimeTree-style, almost invisible)

Bottom Navigation Bar (4 tabs: 홈(active), 내 근무, 알림, 더보기)

---

## Screen 2: Shared Calendar - Day Detail (Bottom Sheet)

Trigger: Tap any date cell in monthly view
Type: Modal Bottom Sheet (radius 20px top corners, drag handle)

Layout:
1. Date header: "3월 5일 (목)" — large text
2. Shift Assignment Section:
   - Grouped by shift type
   - "D 주간 (3명)": 김철수, 이영희, 박지민
   - "N 야간 (2명)": 홍길동, 최수진
   - "OFF 휴무 (1명)": 정민수
   - Each group: ShiftBadge(MD) + member names in body text
   - "미제출: 2명" in gray at bottom
3. Events Section:
   - Event cards with color dot + title + date range

---

## Screen 3: Shared Calendar - Weekly View (Google Calendar Style)

Trigger: Toggle to "주간" in view mode
Purpose: See the team's daily schedule at a glance, like Google Calendar weekly view

Layout:
1. Week Navigator: < 3월 1주차 (1~7일) > (with prev/next arrows)
2. Weekday Header Row: [월1] [화2] [수3] [목4] [금5] [토6] [일7]
   - Weekday colors (일=red, 토=blue), today highlighted with blue circle
3. Event Bars: Colored horizontal bars spanning across day columns for event duration
   - Left colored border (4px) + event title
4. 7-Column Day Grid (Google Calendar weekly view style):
   - Each column = one day (vertical direction)
   - Inside each day column, workers assigned to that day are stacked vertically
   - Each worker card: shift badge colored background + abbreviation + worker name
   - Example for Monday column:
     - [Blue bg] D 김철수
     - [Purple bg] N 이영희
     - [Green bg] OFF 박지민
   - Workers without assignment on that day are not shown
   - Vertical scroll if many workers
   - Column dividers: 0.5px #F2F4F6 between day columns
   - NO left name column, NO horizontal table rows per person

---

## Screen 4: Worker Calendar - My Schedule (Paint Mode)

Route: Second tab "근무 신청"
Purpose: Worker inputs their monthly schedule using Paint Mode

Layout (top to bottom):
1. Header: "내 스케줄" + month display
2. Month Navigator: < 2026년 3월 >
3. Calendar Grid: Same 7-column grid as shared calendar
   - DayCell (worker version):
     - Height: 60px
     - Top-left: day number (with today blue circle)
     - Top-right: ShiftBadge(SM) if assigned
     - When assigned: cell background becomes shift's light bg color (30% opacity)
     - Paint mode tap animation: scale 0.95 -> 1.0 (100ms)
4. Paint Toolbar (Card, radius 12px):
   - Top row: "근무 타입 선택" label + Paint ON/OFF toggle button
     - Paint ON: blue pill button with "Paint ON" text
     - Paint OFF: gray pill button with "Paint OFF" text
   - Bottom row: Wrap of shift type buttons + erase button
     - Each button: colored circle dot (left) + ShiftBadge(LG) text
     - Selected: scale 1.05, full opacity, ring + shadow
     - Unselected: opacity 0.6
     - Erase button: gray style with broom icon
     - Paint OFF state: all buttons at 0.4 opacity
5. Submit Bar (Card, radius 12px):
   - Left: "작성 현황: 10/31일 (32%)" text
   - Right: Submit button or status badge
     - Draft + less than 100%: disabled gray button "제출하기"
     - Draft + 100%: enabled blue button "제출하기"
     - Submitted: green badge with checkmark "제출 완료"
   - Bottom: LinearProgressIndicator (6px height, full radius)
     - 0-50%: orange (#FF9100)
     - 50-99%: blue (#0064FF)
     - 100%: green (#00C853)
6. Legend: Horizontal row of ShiftBadge + label for each shift type

---

## Screen 5: Shift Types Management (Manager)

Route: Settings tab > 근무타입 관리
Purpose: Manager creates/edits/reorders shift types

Layout:
1. AppBar: "근무타입 관리"
2. ReorderableListView:
   - Each row: drag handle (right) + ShiftBadge(MD) + shift name + "약어: D" subtitle + edit/delete icons
   - Drag and drop to reorder
3. FAB (bottom-right): "+" button to add new type

Shift Type Form (Bottom Sheet):
- Title: "새 근무타입" or "근무타입 편집"
- 이름 TextField
- 약어 TextField (1-3 chars)
- Color preset selector: 5 circles (Blue, Purple, Green, Orange, Red)
  - Selected: ring border + checkmark
- 카테고리 Dropdown: 근무조 / 휴가 / 기타
- 저장 button (full-width, primary color)

---

## Screen 6: Vacation MAX Settings (Manager)

Route: Settings tab > 휴가 MAX 관리
Purpose: Set daily maximum vacation slots

Layout:
1. AppBar: "휴가 MAX 관리"
2. Default MAX Card:
   - Title: "일일 기본 휴가 MAX"
   - Stepper: [ - ] 3 [ + ] (large number in center, 24px Bold)
   - Minus/Plus buttons in circles
3. Override Section:
   - Title: "일자별 Override"
   - Input row: Day TextField (1-31) + MAX TextField + "적용" button
   - Chip list (Wrap layout):
     - Each chip: amber background, "15일: 5명" text + delete (x) icon
     - Deletable chips

---

## Screen 7: Event Management (Manager)

Route: Settings tab > 이벤트 관리
Purpose: Create and manage team calendar events

Layout:
1. AppBar: "이벤트 관리"
2. Event List (or empty state with illustration):
   - Each event card: ListTile with
     - Leading: colored circle indicator
     - Title: event name
     - Subtitle: "3/5 ~ 3/7" date range
     - Trailing: delete icon button
   - Tap to edit
3. FAB: "+" button to add new event

Event Form (Bottom Sheet):
- Title: "새 이벤트" or "이벤트 편집"
- 이벤트명 TextField
- Date range: Start date button + "~" + End date button (DatePicker)
- Color selector: 5 preset circles (Blue, Purple, Green, Orange, Red)
- 메모 TextField (2 lines, optional)
- 저장 button (full-width)

---

## Screen 8: Manager Calendar Overview

Purpose: Manager's view of team schedule with vacation tracking

Layout:
1. Header: "CS" logo + "ClearShift" + "매니저" badge
2. Month Navigator: < 2026년 3월 >
3. Calendar Grid: Same grid but DayCell shows:
   - Day number
   - Vacation count: "2/3" (current/max) in small text
   - Event chip
4. Team Overview Card (below calendar):
   - Title: "팀원 현황"
   - Member rows:
     - CircleAvatar with initial (unique color per member)
     - Member name
     - Status badge:
       - "제출 완료" (green bg, white text)
       - "작성중 73%" (orange bg, white text)
       - "미시작" (gray bg)

---

## Screen 9: Day Detail - Manager View (Bottom Sheet)

Trigger: Tap date in manager calendar
Type: Modal Bottom Sheet

Layout:
- Date header: "3월 5일 (목)"
- Member assignment list:
  - Each row: member name + ShiftBadge of their assignment
  - Grouped or flat list
- Vacation count summary: "휴가: 2/3명"

---

## Screen 10: Member Schedule Detail

Purpose: View individual team member's full monthly schedule

Layout:
1. AppBar: "{이름}님 스케줄"
2. Member Info: CircleAvatar + name + "근무자" subtitle
3. Calendar Grid (read-only): Shows member's assignments
4. Stats Summary Card:
   - "근무 통계" title
   - Wrap of stat items: "D: 12일", "N: 8일", "OFF: 5일" etc.
   - Each with ShiftBadge + count
5. Submit Bar (read-only): Shows member's submission status

---

## Navigation Flow Summary (4-tab structure)

App Launch
  -> 홈 (Tab 1, default)
     -> 공유 캘린더 월간 뷰 (default)
        -> Tap date -> Day Detail Sheet
     -> 주간 뷰 (toggle)
        -> Week navigation

  -> 내 근무 (Tab 2)
     -> Paint Mode ON -> Select shift type -> Tap dates
     -> Submit when 100% complete

  -> 알림 (Tab 3)
     -> 팀원 스케줄 제출/변경 알림
     -> 이벤트 알림
     -> Notification badge on tab icon

  -> 더보기 (Tab 4)
     -> 프로필
     -> (Manager only) 근무타입 관리
        -> Add/Edit/Delete/Reorder shift types
     -> (Manager only) 휴가 MAX 설정
        -> Set default MAX, add date overrides
     -> (Manager only) 이벤트 관리
        -> Add/Edit/Delete events
     -> 알림 설정
     -> 로그아웃

---

## Key Interaction Patterns

### Paint Mode (Core UX)
1. User taps "Paint ON" button (turns blue)
2. User selects a shift type (e.g., "D" Day)
3. User taps calendar dates — each tap assigns the selected shift
4. Same type tap = toggle off (remove assignment)
5. Different type tap = replace
6. Erase button selected = tap to remove
7. Progress bar updates in real-time
8. At 100% completion, submit button activates
9. Haptic feedback on each tap

### Bottom Sheet Pattern
- Drag handle at top
- 20px top border radius
- Scroll-aware for keyboard
- Save action closes sheet and updates state

---

## Design Requirements

1. Toss-style minimal: No shadows on cards (use 1px border instead), white backgrounds, generous whitespace
2. TimeTree-style calendar: Minimal cell borders (0.5px light gray), compact cell height (60px), colorful content inside cells
3. Colorful shift badges: The primary visual element — vibrant pill badges that make schedule patterns instantly recognizable
4. Consistent spacing: 4px base grid (4, 8, 12, 16, 20, 24, 32)
5. Card radius: 12px for cards, 20px for bottom sheets, stadium for badges
6. Button radius: 8px
7. No elevation/shadow: Border-based card design (Toss style)
8. Korean text: All UI labels in Korean
9. Accessibility: Minimum touch target 44px, sufficient color contrast
10. Status colors: Green=submitted/success, Orange=in-progress/warning, Red=error/delete, Gray=inactive

---

## Screens to Generate (10 screens total)

1. 공유 캘린더 - 월간 뷰 (main screen with bottom nav)
2. 공유 캘린더 - 날짜 상세 바텀시트
3. 공유 캘린더 - 주간 뷰
4. 내 스케줄 - Paint Mode OFF (empty calendar)
5. 내 스케줄 - Paint Mode ON (partially filled, about 60%)
6. 내 스케줄 - 제출 완료 (100% filled, green status)
7. 근무타입 관리 (with list + FAB)
8. 근무타입 추가 폼 바텀시트
9. 휴가 MAX 설정
10. 이벤트 관리 (with list + FAB)
