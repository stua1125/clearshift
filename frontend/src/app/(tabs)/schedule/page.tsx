"use client";

import { useEffect, useCallback } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { useCalendar } from "@/hooks/use-calendar";
import { usePaintStore } from "@/stores/paint-store";
import { getSchedule, saveAssignments, submitSchedule } from "@/lib/api/schedule";
import { getActiveShiftTypes } from "@/lib/api/shift-types";
import { CalendarHeader } from "@/components/calendar-header";
import { CalendarGrid } from "@/components/calendar-grid";
import { DayCell } from "@/components/day-cell";
import { PaintToolbar } from "@/components/paint-toolbar";
import { SubmitBar } from "@/components/submit-bar";
import type { AssignmentInfo } from "@/types";

export default function SchedulePage() {
  const calendar = useCalendar();
  const queryClient = useQueryClient();
  const {
    selectedShiftTypeId,
    eraserActive,
    assignments,
    selectShiftType,
    toggleEraser,
    assignDay,
    clearDay,
    setAssignments,
  } = usePaintStore();

  const { data: schedule } = useQuery({
    queryKey: ["schedule", calendar.year, calendar.month],
    queryFn: () => getSchedule(calendar.year, calendar.month),
  });

  const { data: shiftTypes = [] } = useQuery({
    queryKey: ["shift-types"],
    queryFn: getActiveShiftTypes,
  });

  // Auto-select first shift type
  useEffect(() => {
    if (shiftTypes.length > 0 && !selectedShiftTypeId && !eraserActive) {
      selectShiftType(shiftTypes[0].id);
    }
  }, [shiftTypes, selectedShiftTypeId, eraserActive, selectShiftType]);

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
      eraserActive,
      selectedShiftTypeId,
      shiftTypes,
      assignments,
      assignDay,
      clearDay,
      saveMutation,
    ]
  );

  const selectedShift = shiftTypes.find((s) => s.id === selectedShiftTypeId);
  const assignedCount = Object.keys(assignments).length;

  return (
    <div className="flex flex-col">
      {/* Page Title */}
      <div className="px-4 pt-4 pb-1">
        <h1 className="text-lg font-bold text-text-primary">
          ✏️ 근무신청
        </h1>
      </div>

      {/* Month Navigation */}
      <CalendarHeader
        year={calendar.year}
        month={calendar.month}
        onPrev={calendar.goToPrevMonth}
        onNext={calendar.goToNextMonth}
        prevLabel="prev-month-worker"
        nextLabel="next-month-worker"
      />

      {/* Selection Status */}
      <div className="mx-4 rounded-lg bg-primary-container px-3 py-2 text-sm">
        {eraserActive ? (
          <span className="text-text-primary">
            🧹 지우개 모드 — 탭해서 삭제
          </span>
        ) : selectedShift ? (
          <span className="text-text-primary">
            <span
              className="mr-1 inline-block size-2 rounded-full"
              style={{ backgroundColor: selectedShift.color }}
            />
            {selectedShift.name} 선택됨 — 탭하거나 드래그해서 등록
          </span>
        ) : (
          <span className="text-text-secondary">
            아래에서 근무 타입을 선택하세요
          </span>
        )}
      </div>

      {/* Calendar */}
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
              onClick={() => day > 0 && handleCellClick(day)}
            />
          ))
        )}
      </CalendarGrid>

      {/* Spacer to push toolbar + submit to bottom */}
      <div className="flex-1" />

      {/* Paint Toolbar (bottom) */}
      <PaintToolbar
        shiftTypes={shiftTypes}
        selectedId={selectedShiftTypeId}
        eraserActive={eraserActive}
        onSelectShift={selectShiftType}
        onToggleEraser={toggleEraser}
      />

      {/* Submit Bar */}
      {schedule?.status !== "SUBMITTED" ? (
        <SubmitBar
          assigned={assignedCount}
          total={calendar.daysInMonth}
          onSubmit={() => submitMutation.mutate()}
          isSubmitting={submitMutation.isPending}
        />
      ) : (
        <div className="px-4 py-3 text-center text-sm font-medium text-success">
          제출 완료 ({schedule.submittedAt?.slice(0, 10)})
        </div>
      )}
    </div>
  );
}
