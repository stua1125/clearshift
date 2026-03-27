const WEEKDAY_NAMES = ["일", "월", "화", "수", "목", "금", "토"] as const;

/**
 * Formats as "YYYY년 M월"
 */
export function formatYearMonth(year: number, month: number): string {
  return `${year}년 ${month}월`;
}

/**
 * Formats as "M월 D일 (요일)"
 */
export function formatDateFull(year: number, month: number, day: number): string {
  const dow = new Date(year, month - 1, day).getDay();
  return `${month}월 ${day}일 (${WEEKDAY_NAMES[dow]})`;
}

/**
 * Returns the Korean weekday name (일, 월, 화, ...).
 */
export function getWeekdayName(dayOfWeek: number): string {
  return WEEKDAY_NAMES[dayOfWeek];
}

/**
 * Formats an ISO date string as "M/D".
 */
export function formatShortDate(isoDate: string): string {
  const d = new Date(isoDate);
  return `${d.getMonth() + 1}/${d.getDate()}`;
}

/**
 * Returns all 7 weekday headers.
 */
export function getWeekdayHeaders(): readonly string[] {
  return WEEKDAY_NAMES;
}
