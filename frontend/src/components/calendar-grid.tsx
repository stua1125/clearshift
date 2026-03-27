"use client";

import { getWeekdayHeaders } from "@/lib/utils/format";
import { cn } from "@/lib/utils";

interface CalendarGridProps {
  children: React.ReactNode;
  className?: string;
}

export function CalendarGrid({ children, className }: CalendarGridProps) {
  const headers = getWeekdayHeaders();

  return (
    <div className={className}>
      <div className="calendar-grid">
        {headers.map((label, i) => (
          <div
            key={label}
            className={cn(
              "py-2 text-center text-xs font-medium",
              i === 0 && "text-sunday",
              i === 6 && "text-saturday",
              i > 0 && i < 6 && "text-text-secondary"
            )}
          >
            {label}
          </div>
        ))}
      </div>
      <div className="calendar-grid border-t border-border-light">
        {children}
      </div>
    </div>
  );
}
