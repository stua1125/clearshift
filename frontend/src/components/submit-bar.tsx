"use client";

import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";

interface SubmitBarProps {
  assigned: number;
  total: number;
  onSubmit: () => void;
  isSubmitting?: boolean;
  className?: string;
}

export function SubmitBar({
  assigned,
  total,
  onSubmit,
  isSubmitting = false,
  className,
}: SubmitBarProps) {
  const percent = total > 0 ? Math.round((assigned / total) * 100) : 0;
  const isComplete = percent >= 100;

  return (
    <div className={cn("space-y-2 px-4 py-3", className)}>
      <div className="flex items-center justify-between text-sm">
        <span className="text-text-primary">
          작성 현황: {assigned}/{total}일
        </span>
        <span
          className={cn(
            "font-semibold",
            isComplete
              ? "text-success"
              : percent >= 50
                ? "text-primary"
                : "text-warning"
          )}
        >
          {percent}%
        </span>
      </div>
      <div className="h-2 overflow-hidden rounded-full bg-surface-variant">
        <div
          className={cn(
            "h-full rounded-full transition-all duration-300",
            isComplete
              ? "bg-success"
              : percent >= 50
                ? "bg-primary"
                : "bg-warning"
          )}
          style={{ width: `${Math.min(percent, 100)}%` }}
        />
      </div>
      <Button
        data-testid="submit-button"
        onClick={onSubmit}
        disabled={!isComplete || isSubmitting}
        className="w-full"
      >
        {isSubmitting
          ? "제출 중..."
          : `제출하기 (${percent}%)`}
      </Button>
    </div>
  );
}
