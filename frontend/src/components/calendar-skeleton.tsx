import { cn } from "@/lib/utils";

export function CalendarSkeleton() {
  return (
    <div className="animate-pulse">
      {/* Header */}
      <div className="flex items-center justify-between px-4 py-3">
        <div className="h-6 w-32 rounded-md bg-surface-variant" />
        <div className="h-8 w-20 rounded-lg bg-surface-variant" />
      </div>
      {/* Weekday headers */}
      <div className="calendar-grid px-0">
        {Array.from({ length: 7 }).map((_, i) => (
          <div key={i} className="flex justify-center py-2">
            <div className="h-4 w-6 rounded bg-surface-variant" />
          </div>
        ))}
      </div>
      {/* Grid cells */}
      <div className="calendar-grid border-t border-border-light">
        {Array.from({ length: 35 }).map((_, i) => (
          <div
            key={i}
            className={cn("day-cell", i < 2 && "opacity-0")}
          >
            <div className="h-3 w-4 rounded bg-surface-variant" />
          </div>
        ))}
      </div>
    </div>
  );
}
