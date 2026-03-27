"use client";

import { useQuery } from "@tanstack/react-query";
import { getMonthlyCalendar } from "@/lib/api/calendar";
import { CalendarGrid } from "@/components/calendar-grid";
import { SharedDayCell } from "./shared-day-cell";

interface SharedMonthlyViewProps {
  year: number;
  month: number;
  weekRows: number[][];
  firstDayOfWeek: number;
  daysInMonth: number;
}

export function SharedMonthlyView({
  year,
  month,
  weekRows,
}: SharedMonthlyViewProps) {
  const { data } = useQuery({
    queryKey: ["shared-calendar", "monthly", year, month],
    queryFn: () => getMonthlyCalendar(year, month),
  });

  return (
    <CalendarGrid>
      {weekRows.flatMap((row, rowIdx) =>
        row.map((day, colIdx) => (
          <SharedDayCell
            key={`${rowIdx}-${colIdx}`}
            day={day}
            dayOfWeek={colIdx}
            summary={day > 0 ? data?.daySummaries[day] : undefined}
          />
        ))
      )}
    </CalendarGrid>
  );
}
