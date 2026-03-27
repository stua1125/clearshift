"use client";

import { Paintbrush } from "lucide-react";
import { cn } from "@/lib/utils";

interface PaintModeToggleProps {
  active: boolean;
  onToggle: () => void;
}

export function PaintModeToggle({ active, onToggle }: PaintModeToggleProps) {
  return (
    <button
      type="button"
      data-testid="paint-mode-toggle"
      onClick={onToggle}
      className={cn(
        "flex items-center gap-1 rounded-full px-3 py-1.5 text-xs font-semibold transition-colors",
        active
          ? "bg-primary text-on-primary"
          : "bg-surface-variant text-text-secondary"
      )}
    >
      <Paintbrush className="size-3.5" />
      {active ? "ON" : "OFF"}
    </button>
  );
}
