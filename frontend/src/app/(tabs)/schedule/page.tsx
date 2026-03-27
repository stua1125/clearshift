"use client";

import { useEffect, useState, useCallback } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useCalendar } from "@/hooks/use-calendar";
import { usePaintStore } from "@/stores/paint-store";
import { getSchedule, saveAssignments, submitSchedule } from "@/lib/api/schedule";
import { getShiftTypes } from "@/lib/api/shift-types";
import { CalendarHeader } from "@/components/calendar-header";
import { CalendarGrid } from "@/components/calendar-grid";
import { DayCell } from "@/components/day-cell";
import { PaintToolbar } from "@/components/paint-toolbar";
import { SubmitBar } from "@/components/submit-bar";
import { PaintModeToggle } from "./_components/paint-mode-toggle";
import type { AssignmentInfo } from "@/types";

export default function SchedulePage() {
  const calendar = useCalendar();
  const queryClient = useQueryClient();
  const {
    paintMode,
    selectedShiftTypeId,
    assignments,
    togglePaintMode,
    selectShiftType,
    assignDay,
    clearDay,
    setAssignments,
  } = usePaintStore();

  const [eraserActive, setEraserActive] = useState(false);

  const { data: schedule } = useQuery({
    queryKey: ["schedule", calendar.year, calendar.month],
    queryFn: () => getSchedule(calendar.year, calendar.month),
  });

  const { data: shiftTypes = [] } = useQuery({
    queryKey: ["shift-types"],
    queryFn: getShiftTypes,
  });

  // Sync server assignments to store
  useEffect(() => {
    if (schedule?.assignments) {
      setAssignments(schedule.assignments);
    }
  }, [schedule, setAssignments]);

  const saveMutation = useMutation({
    mutationFn: () => {
      const mapped: Record<number, string> = {};
      for (const [day, info] of Object.entries(assignments)) {
        mapped[Number(day)] = info.shiftTypeId;
      }
      return saveAssignments(calendar.year, calendar.month, {
        assignments: mapped,
      });
    },
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: ["schedule", calendar.year, calendar.month],
      });
    },
  });

  const submitMutation = useMutation({
    mutationFn: () => submitSchedule(calendar.year, calendar.month),
    onSuccess: () => {
      queryClient.invalidateQueries({
        queryKey: ["schedule", calendar.year, calendar.month],
      });
    },
  });

  const handleCellClick = useCallback(
    (day: number) => {
      if (!paintMode) return;

      if (eraserActive) {
        clearDay(day);
        saveMutation.mutate();
        return;
      }

      if (!selectedShiftTypeId) return;

      const shift = shiftTypes.find((s) => s.id === selectedShiftTypeId);
      if (!shift) return;

      // Toggle: if same shift already assigned, remove it
      const current = assignments[day];
      if (current?.shiftTypeId === selectedShiftTypeId) {
        clearDay(day);
      } else {
        const info: AssignmentInfo = {
          shiftTypeId: shift.id,
          shiftTypeName: shift.name,
          abbreviation: shift.abbreviation,
          color: shift.color,
          bgColor: shift.bgColor,
        };
        assignDay(day, info);
      }
      saveMutation.mutate();
    },
    [
      paintMode,
      eraserActive,
      selectedShiftTypeId,
      shiftTypes,
      assignments,
      assignDay,
      clearDay,
      saveMutation,
    ]
  );

  const handleSelectShift = (id: string) => {
    setEraserActive(false);
    selectShiftType(id);
  };

  const handleToggleEraser = () => {
    setEraserActive(!eraserActive);
    selectShiftType(null);
  };

  const assignedCount = Object.keys(assignments).length;

  return (
    <div>
      <CalendarHeader
        year={calendar.year}
        month={calendar.month}
        onPrev={calendar.goToPrevMonth}
        onNext={calendar.goToNextMonth}
        prevLabel="prev-month-worker"
        nextLabel="next-month-worker"
      >
        <PaintModeToggle active={paintMode} onToggle={togglePaintMode} />
      </CalendarHeader>

      {paintMode && (
        <PaintToolbar
          shiftTypes={shiftTypes}
          selectedId={selectedShiftTypeId}
          eraserActive={eraserActive}
          onSelectShift={handleSelectShift}
          onToggleEraser={handleToggleEraser}
        />
      )}

      <CalendarGrid>
        {calendar.weekRows.flatMap((row, rowIdx) =>
          row.map((day, colIdx) => (
            <DayCell
              key={`${rowIdx}-${colIdx}`}
              day={day}
              dayOfWeek={colIdx}
              isToday={
                day > 0 &&
                new Date().getDate() === day &&
                new Date().getMonth() + 1 === calendar.month &&
                new Date().getFullYear() === calendar.year
              }
              assignment={day > 0 ? assignments[day] : undefined}
              paintMode={paintMode}
              onClick={() => day > 0 && handleCellClick(day)}
            />
          ))
        )}
      </CalendarGrid>

      {schedule?.status !== "SUBMITTED" && (
        <SubmitBar
          assigned={assignedCount}
          total={calendar.daysInMonth}
          onSubmit={() => submitMutation.mutate()}
          isSubmitting={submitMutation.isPending}
        />
      )}

      {schedule?.status === "SUBMITTED" && (
        <div className="px-lg py-md text-center text-sm font-medium text-success">
          제출 완료 ({schedule.submittedAt?.slice(0, 10)})
        </div>
      )}
    </div>
  );
}
