"use client";

import { ChevronLeft, ChevronRight } from "lucide-react";
import { formatYearMonth } from "@/lib/utils/format";
import { cn } from "@/lib/utils";

interface CalendarHeaderProps {
  year: number;
  month: number;
  onPrev: () => void;
  onNext: () => void;
  prevLabel?: string;
  nextLabel?: string;
  children?: React.ReactNode;
  className?: string;
}

export function CalendarHeader({
  year,
  month,
  onPrev,
  onNext,
  prevLabel = "prev-month",
  nextLabel = "next-month",
  children,
  className,
}: CalendarHeaderProps) {
  return (
    <div
      className={cn(
        "flex items-center justify-between px-lg py-md",
        className
      )}
    >
      <div className="flex items-center gap-sm">
        <button
          type="button"
          data-testid={prevLabel}
          onClick={onPrev}
          className="flex size-10 items-center justify-center rounded-md text-text-secondary hover:bg-surface-variant"
        >
          <ChevronLeft className="size-5" />
        </button>
        <h2 className="text-base font-semibold text-text-primary">
          {formatYearMonth(year, month)}
        </h2>
        <button
          type="button"
          data-testid={nextLabel}
          onClick={onNext}
          className="flex size-10 items-center justify-center rounded-md text-text-secondary hover:bg-surface-variant"
        >
          <ChevronRight className="size-5" />
        </button>
      </div>
      {children}
    </div>
  );
}
