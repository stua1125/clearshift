export interface ShiftCount {
  count: number;
  color: string;
  bgColor: string;
}

export interface DayShiftSummary {
  shiftCounts: Record<string, ShiftCount>;
  totalMembers: number;
  submittedCount: number;
}

export interface EventInfo {
  id: string;
  title: string;
  startDate: string;
  endDate: string;
  color: string;
  memo?: string;
}

export interface SharedCalendarMonthlyResponse {
  year: number;
  month: number;
  daySummaries: Record<number, DayShiftSummary>;
  events: EventInfo[];
}

export interface ShiftInfo {
  abbreviation: string;
  name: string;
  color: string;
  bgColor: string;
}

export interface MemberWeekRow {
  userId: string;
  userName: string;
  profileImageUrl?: string;
  assignments: Record<number, ShiftInfo>;
}

export interface SharedCalendarWeeklyResponse {
  year: number;
  month: number;
  weekStartDay: number;
  members: MemberWeekRow[];
  events: EventInfo[];
}
