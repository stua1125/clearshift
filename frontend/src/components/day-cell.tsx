"use client";

import { cn } from "@/lib/utils";
import { ShiftBadge } from "./shift-badge";
import type { AssignmentInfo } from "@/types";

interface DayCellProps {
  day: number;
  dayOfWeek: number;
  isToday?: boolean;
  assignment?: AssignmentInfo;
  paintMode?: boolean;
  onClick?: () => void;
  className?: string;
}

export function DayCell({
  day,
  dayOfWeek,
  isToday = false,
  assignment,
  paintMode = false,
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
        "day-cell relative flex flex-col items-start text-left transition-colors",
        "hover:bg-cell-hover",
        paintMode && "cursor-pointer active:scale-95",
        !paintMode && "cursor-default",
        isToday && "ring-2 ring-primary ring-inset",
        assignment && "bg-opacity-40",
        className
      )}
      style={
        assignment
          ? { backgroundColor: `${assignment.bgColor}66` }
          : undefined
      }
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
      {assignment && (
        <ShiftBadge
          abbreviation={assignment.abbreviation}
          color={assignment.color}
          bgColor={assignment.bgColor}
        />
      )}
    </button>
  );
}
