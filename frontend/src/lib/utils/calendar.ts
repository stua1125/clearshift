/**
 * Returns the number of days in a given month.
 */
export function getDaysInMonth(year: number, month: number): number {
  return new Date(year, month, 0).getDate();
}

/**
 * Returns the day of the week (0=Sun, 6=Sat) for the 1st of the month.
 */
export function getFirstDayOfWeek(year: number, month: number): number {
  return new Date(year, month - 1, 1).getDay();
}

/**
 * Returns week rows for the calendar grid.
 * Each row is an array of 7 day numbers (0 = empty cell).
 */
export function getWeekRows(year: number, month: number): number[][] {
  const days = getDaysInMonth(year, month);
  const firstDay = getFirstDayOfWeek(year, month);
  const rows: number[][] = [];
  let current = 1;

  for (let week = 0; current <= days; week++) {
    const row: number[] = [];
    for (let dow = 0; dow < 7; dow++) {
      if (week === 0 && dow < firstDay) {
        row.push(0);
      } else if (current > days) {
        row.push(0);
      } else {
        row.push(current++);
      }
    }
    rows.push(row);
  }

  return rows;
}

/**
 * Returns the ISO week number for a given date.
 */
export function getWeekNumber(year: number, month: number, day: number): number {
  const date = new Date(year, month - 1, day);
  const startOfYear = new Date(date.getFullYear(), 0, 1);
  const diff = date.getTime() - startOfYear.getTime();
  const oneWeek = 7 * 24 * 60 * 60 * 1000;
  return Math.ceil((diff / oneWeek + startOfYear.getDay() + 1) / 7);
}
