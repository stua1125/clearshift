"use client";

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import {
  getVacationLimits,
  updateDefaultMax,
  setOverride,
  deleteOverride,
} from "@/lib/api/vacation";
import { useCalendar } from "@/hooks/use-calendar";
import { ManagerGuard } from "@/components/manager-guard";
import { CalendarHeader } from "@/components/calendar-header";
import { Button } from "@/components/ui/button";
import { ArrowLeft, Minus, Plus, X } from "lucide-react";
import Link from "next/link";
import { formatShortDate } from "@/lib/utils/format";
import { useState } from "react";

export default function VacationPage() {
  const calendar = useCalendar();
  const queryClient = useQueryClient();
  const qk = ["vacation-limits", calendar.year, calendar.month];

  const { data } = useQuery({
    queryKey: qk,
    queryFn: () => getVacationLimits(calendar.year, calendar.month),
  });

  const updateDefaultMut = useMutation({
    mutationFn: updateDefaultMax,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: qk }),
  });

  const addOverrideMut = useMutation({
    mutationFn: setOverride,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: qk }),
  });

  const deleteOverrideMut = useMutation({
    mutationFn: deleteOverride,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: qk }),
  });

  const [overrideDate, setOverrideDate] = useState("");
  const [overrideCount, setOverrideCount] = useState(1);

  const defaultMax = data?.defaultMax ?? 2;

  return (
    <ManagerGuard>
    <div className="p-4">
      <div className="flex items-center gap-2">
        <Link
          href="/settings"
          className="flex size-10 items-center justify-center rounded-md text-text-secondary hover:bg-surface-variant"
        >
          <ArrowLeft className="size-5" />
        </Link>
        <h1 className="text-xl font-bold">휴가 설정</h1>
      </div>

      <CalendarHeader
        year={calendar.year}
        month={calendar.month}
        onPrev={calendar.goToPrevMonth}
        onNext={calendar.goToNextMonth}
        className="mt-4 px-0"
      />

      {/* Default Max */}
      <div className="mt-4 rounded-lg border border-border-light p-4">
        <p className="text-sm font-medium">일별 기본 휴가 인원</p>
        <div className="mt-2 flex items-center gap-4">
          <button
            type="button"
            onClick={() =>
              defaultMax > 0 && updateDefaultMut.mutate(defaultMax - 1)
            }
            className="flex size-10 items-center justify-center rounded-full bg-surface-variant text-text-secondary"
          >
            <Minus className="size-4" />
          </button>
          <span className="text-2xl font-bold">{defaultMax}</span>
          <button
            type="button"
            onClick={() => updateDefaultMut.mutate(defaultMax + 1)}
            className="flex size-10 items-center justify-center rounded-full bg-surface-variant text-text-secondary"
          >
            <Plus className="size-4" />
          </button>
          <span className="text-sm text-text-secondary">명</span>
        </div>
      </div>

      {/* Overrides */}
      <div className="mt-4">
        <h2 className="text-sm font-semibold text-text-secondary">
          날짜별 예외 설정
        </h2>
        <div className="mt-2 space-y-2">
          {data?.overrides.map((ov) => (
            <div
              key={ov.id}
              className="flex items-center justify-between rounded-lg border border-border-light px-3 py-2"
            >
              <span className="text-sm">
                {formatShortDate(ov.targetDate)} — 최대{" "}
                <span className="font-semibold">{ov.maxCount}</span>명
              </span>
              <button
                type="button"
                onClick={() => deleteOverrideMut.mutate(ov.id)}
                className="p-1 text-text-tertiary hover:text-error"
              >
                <X className="size-4" />
              </button>
            </div>
          ))}
        </div>

        {/* Add Override */}
        <div className="mt-3 flex items-end gap-2">
          <div className="flex-1">
            <label className="mb-1 block text-xs text-text-secondary">
              날짜
            </label>
            <input
              type="date"
              value={overrideDate}
              onChange={(e) => setOverrideDate(e.target.value)}
              className="w-full rounded-md border border-border bg-surface-variant px-3 py-2 text-sm outline-none"
            />
          </div>
          <div className="w-20">
            <label className="mb-1 block text-xs text-text-secondary">
              인원
            </label>
            <input
              type="number"
              min={0}
              value={overrideCount}
              onChange={(e) => setOverrideCount(Number(e.target.value))}
              className="w-full rounded-md border border-border bg-surface-variant px-3 py-2 text-sm outline-none"
            />
          </div>
          <Button
            onClick={() => {
              if (overrideDate)
                addOverrideMut.mutate({
                  date: overrideDate,
                  maxCount: overrideCount,
                });
            }}
            size="sm"
          >
            추가
          </Button>
        </div>
      </div>
    </div>
    </ManagerGuard>
  );
}
