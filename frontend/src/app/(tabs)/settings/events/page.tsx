"use client";

import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import {
  getEvents,
  createEvent,
  updateEvent,
  deleteEvent,
} from "@/lib/api/events";
import { useCalendar } from "@/hooks/use-calendar";
import { CalendarHeader } from "@/components/calendar-header";
import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { ArrowLeft, Plus, Pencil, Trash2 } from "lucide-react";
import Link from "next/link";
import { formatShortDate } from "@/lib/utils/format";
import type { CalendarEvent } from "@/types";

const EVENT_COLORS = [
  "#0064FF",
  "#FF9100",
  "#6C5CE7",
  "#00B894",
  "#FF3B30",
  "#94A3B8",
];

export default function EventsPage() {
  const calendar = useCalendar();
  const queryClient = useQueryClient();
  const qk = ["events", calendar.year, calendar.month];
  const [editingEvent, setEditingEvent] = useState<CalendarEvent | null>(null);
  const [sheetOpen, setSheetOpen] = useState(false);

  const { data: events = [] } = useQuery({
    queryKey: qk,
    queryFn: () => getEvents(calendar.year, calendar.month),
  });

  const createMut = useMutation({
    mutationFn: createEvent,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: qk });
      setSheetOpen(false);
    },
  });

  const updateMut = useMutation({
    mutationFn: ({ id, ...data }: CalendarEvent) => updateEvent(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: qk });
      setSheetOpen(false);
      setEditingEvent(null);
    },
  });

  const deleteMut = useMutation({
    mutationFn: deleteEvent,
    onSuccess: () => queryClient.invalidateQueries({ queryKey: qk }),
  });

  return (
    <div className="p-lg">
      <div className="flex items-center gap-sm">
        <Link
          href="/settings"
          className="flex size-10 items-center justify-center rounded-md text-text-secondary hover:bg-surface-variant"
        >
          <ArrowLeft className="size-5" />
        </Link>
        <h1 className="text-xl font-bold">이벤트 관리</h1>
      </div>

      <CalendarHeader
        year={calendar.year}
        month={calendar.month}
        onPrev={calendar.goToPrevMonth}
        onNext={calendar.goToNextMonth}
        className="mt-lg px-0"
      />

      <div className="mt-lg space-y-sm">
        {events.map((ev) => (
          <div
            key={ev.id}
            className="flex items-center gap-md rounded-lg border border-border-light p-md"
          >
            <div
              className="size-3 shrink-0 rounded-full"
              style={{ backgroundColor: ev.color }}
            />
            <div className="flex-1">
              <p className="text-sm font-medium">{ev.title}</p>
              <p className="text-xs text-text-secondary">
                {formatShortDate(ev.startDate)} ~{" "}
                {formatShortDate(ev.endDate)}
              </p>
            </div>
            <button
              type="button"
              onClick={() => {
                setEditingEvent(ev);
                setSheetOpen(true);
              }}
              className="p-2 text-text-secondary hover:text-text-primary"
            >
              <Pencil className="size-4" />
            </button>
            <button
              type="button"
              onClick={() => {
                if (confirm(`"${ev.title}" 이벤트를 삭제하시겠습니까?`))
                  deleteMut.mutate(ev.id);
              }}
              className="p-2 text-text-secondary hover:text-error"
            >
              <Trash2 className="size-4" />
            </button>
          </div>
        ))}
        {events.length === 0 && (
          <p className="py-8 text-center text-sm text-text-secondary">
            등록된 이벤트가 없습니다
          </p>
        )}
      </div>

      <Button
        onClick={() => {
          setEditingEvent(null);
          setSheetOpen(true);
        }}
        className="mt-lg w-full gap-1"
      >
        <Plus className="size-4" />
        이벤트 추가
      </Button>

      <Sheet open={sheetOpen} onOpenChange={setSheetOpen}>
        <SheetContent side="bottom" className="rounded-t-xl">
          <SheetHeader>
            <SheetTitle>
              {editingEvent ? "이벤트 수정" : "이벤트 추가"}
            </SheetTitle>
          </SheetHeader>
          <EventForm
            initial={editingEvent}
            onSubmit={(data) => {
              if (editingEvent) {
                updateMut.mutate({ ...editingEvent, ...data });
              } else {
                createMut.mutate(data);
              }
            }}
            isPending={createMut.isPending || updateMut.isPending}
          />
        </SheetContent>
      </Sheet>
    </div>
  );
}

function EventForm({
  initial,
  onSubmit,
  isPending,
}: {
  initial: CalendarEvent | null;
  onSubmit: (data: Omit<CalendarEvent, "id" | "createdAt">) => void;
  isPending: boolean;
}) {
  const [title, setTitle] = useState(initial?.title ?? "");
  const [startDate, setStartDate] = useState(initial?.startDate ?? "");
  const [endDate, setEndDate] = useState(initial?.endDate ?? "");
  const [color, setColor] = useState(initial?.color ?? EVENT_COLORS[0]);
  const [memo, setMemo] = useState(initial?.memo ?? "");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit({ title, startDate, endDate, color, memo: memo || undefined });
  };

  return (
    <form onSubmit={handleSubmit} className="mt-lg space-y-lg">
      <div>
        <label className="mb-1 block text-sm font-medium">제목</label>
        <input
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          required
          className="w-full rounded-md border border-border bg-surface-variant px-md py-sm text-sm outline-none focus:border-primary"
        />
      </div>
      <div className="flex gap-sm">
        <div className="flex-1">
          <label className="mb-1 block text-sm font-medium">시작일</label>
          <input
            type="date"
            value={startDate}
            onChange={(e) => setStartDate(e.target.value)}
            required
            className="w-full rounded-md border border-border bg-surface-variant px-md py-sm text-sm outline-none"
          />
        </div>
        <div className="flex-1">
          <label className="mb-1 block text-sm font-medium">종료일</label>
          <input
            type="date"
            value={endDate}
            onChange={(e) => setEndDate(e.target.value)}
            required
            className="w-full rounded-md border border-border bg-surface-variant px-md py-sm text-sm outline-none"
          />
        </div>
      </div>
      <div>
        <label className="mb-1 block text-sm font-medium">색상</label>
        <div className="flex gap-sm">
          {EVENT_COLORS.map((c) => (
            <button
              key={c}
              type="button"
              onClick={() => setColor(c)}
              className="size-8 rounded-full ring-offset-2 transition-all"
              style={{
                backgroundColor: c,
                ...(c === color ? { boxShadow: `0 0 0 2px ${c}` } : {}),
              }}
            />
          ))}
        </div>
      </div>
      <div>
        <label className="mb-1 block text-sm font-medium">메모</label>
        <textarea
          value={memo}
          onChange={(e) => setMemo(e.target.value)}
          rows={2}
          className="w-full rounded-md border border-border bg-surface-variant px-md py-sm text-sm outline-none focus:border-primary"
        />
      </div>
      <Button type="submit" disabled={isPending} className="w-full">
        {isPending ? "저장 중..." : "저장"}
      </Button>
    </form>
  );
}
