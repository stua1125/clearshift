"use client";

import { cn } from "@/lib/utils";
import type { AssignmentInfo } from "@/types";

interface DayCellProps {
  day: number;
  dayOfWeek: number;
  isToday?: boolean;
  assignment?: AssignmentInfo;
  onClick?: () => void;
  className?: string;
}

export function DayCell({
  day,
  dayOfWeek,
  isToday = false,
  assignment,
  onClick,
  className,
}: DayCellProps) {
  if (day === 0) {
    return <div className="day-cell" />;
  }

  const isSunday = dayOfWeek === 0;
  const isSaturday = dayOfWeek === 6;

  return (
    <button
      type="button"
      data-testid={`day-cell-${day}`}
      onClick={onClick}
      className={cn(
        "day-cell relative flex flex-col items-start gap-0.5 text-left transition-colors",
        "cursor-pointer active:scale-95",
        "hover:bg-cell-hover",
        className
      )}
      style={
        assignment
          ? { backgroundColor: `${assignment.bgColor}40` }
          : undefined
      }
    >
      {isToday ? (
        <span className="flex size-6 items-center justify-center rounded-full bg-primary text-xs font-bold text-white">
          {day}
        </span>
      ) : (
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
      )}
      {assignment && (
        <span
          className="text-[10px] font-semibold leading-tight"
          style={{ color: assignment.color }}
        >
          {assignment.shiftTypeName}
        </span>
      )}
    </button>
  );
}
