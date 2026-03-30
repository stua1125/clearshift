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
        "flex items-end justify-center gap-4 border-t border-border-light px-4 pb-2 pt-3",
        className
      )}
    >
      {shiftTypes
        .filter((s) => s.active)
        .map((shift) => {
          const isSelected = selectedId === shift.id && !eraserActive;
          return (
            <button
              key={shift.id}
              type="button"
              data-testid={`shift-btn-${shift.abbreviation}`}
              onClick={() => onSelectShift(shift.id)}
              className="flex flex-col items-center gap-1"
            >
              <div
                className={cn(
                  "flex size-14 items-center justify-center rounded-2xl text-sm font-bold transition-all",
                  isSelected && "ring-2 ring-primary ring-offset-2"
                )}
                style={{
                  backgroundColor: shift.bgColor,
                  color: shift.color,
                }}
              >
                {shift.name.length <= 3 ? shift.name : shift.abbreviation}
              </div>
              <span className="text-[10px] text-text-secondary">
                {shift.name}
              </span>
            </button>
          );
        })}
      <button
        type="button"
        data-testid="eraser-btn"
        onClick={onToggleEraser}
        className="flex flex-col items-center gap-1"
      >
        <div
          className={cn(
            "flex size-14 items-center justify-center rounded-2xl bg-surface-variant text-text-secondary transition-all",
            eraserActive && "ring-2 ring-primary ring-offset-2"
          )}
        >
          <Eraser className="size-5" />
        </div>
        <span className="text-[10px] text-text-secondary">지우개</span>
      </button>
    </div>
  );
}
