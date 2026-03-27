"use client";

import { Eraser } from "lucide-react";
import { cn } from "@/lib/utils";
import type { ShiftType } from "@/types";

interface PaintToolbarProps {
  shiftTypes: ShiftType[];
  selectedId: string | null;
  eraserActive: boolean;
  onSelectShift: (id: string) => void;
  onToggleEraser: () => void;
  className?: string;
}

export function PaintToolbar({
  shiftTypes,
  selectedId,
  eraserActive,
  onSelectShift,
  onToggleEraser,
  className,
}: PaintToolbarProps) {
  return (
    <div
      className={cn(
        "flex items-center gap-sm overflow-x-auto px-lg py-sm",
        className
      )}
    >
      {shiftTypes
        .filter((s) => s.isActive)
        .map((shift) => {
          const isSelected = selectedId === shift.id && !eraserActive;
          return (
            <button
              key={shift.id}
              type="button"
              data-testid={`shift-btn-${shift.abbreviation}`}
              onClick={() => onSelectShift(shift.id)}
              className={cn(
                "flex size-12 shrink-0 items-center justify-center rounded-full text-[11px] font-bold transition-all",
                isSelected && "scale-110 ring-2 ring-primary"
              )}
              style={{
                backgroundColor: shift.color,
                color: "#FFFFFF",
              }}
            >
              {shift.abbreviation}
            </button>
          );
        })}
      <button
        type="button"
        data-testid="eraser-btn"
        onClick={onToggleEraser}
        className={cn(
          "flex size-12 shrink-0 items-center justify-center rounded-full bg-surface-variant text-text-secondary transition-all",
          eraserActive && "scale-110 ring-2 ring-primary"
        )}
      >
        <Eraser className="size-5" />
      </button>
    </div>
  );
}
