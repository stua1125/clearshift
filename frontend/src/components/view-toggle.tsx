"use client";

import { cn } from "@/lib/utils";

type ViewMode = "monthly" | "weekly";

interface ViewToggleProps {
  mode: ViewMode;
  onChange: (mode: ViewMode) => void;
  className?: string;
}

export function ViewToggle({ mode, onChange, className }: ViewToggleProps) {
  return (
    <div className={cn("flex gap-1 rounded-lg bg-surface-variant p-1", className)}>
      <button
        type="button"
        data-testid="view-monthly"
        onClick={() => onChange("monthly")}
        className={cn(
          "rounded-md px-3 py-1.5 text-xs font-medium transition-colors",
          mode === "monthly"
            ? "bg-surface text-primary shadow-sm"
            : "text-text-secondary hover:text-text-primary"
        )}
      >
        월간
      </button>
      <button
        type="button"
        data-testid="view-weekly"
        onClick={() => onChange("weekly")}
        className={cn(
          "rounded-md px-3 py-1.5 text-xs font-medium transition-colors",
          mode === "weekly"
            ? "bg-surface text-primary shadow-sm"
            : "text-text-secondary hover:text-text-primary"
        )}
      >
        주간
      </button>
    </div>
  );
}
