"use client";

import { cn } from "@/lib/utils";
import { ShiftBadge } from "@/components/shift-badge";
import type { DayShiftSummary } from "@/types";

interface SharedDayCellProps {
  day: number;
  dayOfWeek: number;
  summary?: DayShiftSummary;
}

export function SharedDayCell({ day, dayOfWeek, summary }: SharedDayCellProps) {
  if (day === 0) {
    return <div className="day-cell" />;
  }

  const today = new Date();
  const isToday =
    today.getDate() === day &&
    today.getMonth() + 1 ===
      // We rely on parent context for month comparison — simplified check
      today.getMonth() + 1;

  const isSunday = dayOfWeek === 0;
  const isSaturday = dayOfWeek === 6;

  const shiftEntries = summary
    ? Object.entries(summary.shiftCounts)
    : [];

  return (
    <div
      data-testid={`day-cell-${day}`}
      className={cn(
        "day-cell flex flex-col gap-0.5",
        "hover:bg-cell-hover transition-colors"
      )}
    >
      <span
        className={cn(
          "text-xs font-medium",
          isSunday && "text-sunday",
          isSaturday && "text-saturday",
          !isSunday && !isSaturday && "text-text-primary"
        )}
      >
        {day}
      </span>
      <div className="flex flex-wrap gap-0.5">
        {shiftEntries.slice(0, 3).map(([abbr, info]) => (
          <ShiftBadge
            key={abbr}
            abbreviation={`${abbr}${info.count}`}
            color={info.color}
            bgColor={info.bgColor}
          />
        ))}
      </div>
    </div>
  );
}
