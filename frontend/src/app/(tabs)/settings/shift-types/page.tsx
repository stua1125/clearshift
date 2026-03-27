"use client";

import { useState } from "react";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import {
  getShiftTypes,
  createShiftType,
  updateShiftType,
  deleteShiftType,
} from "@/lib/api/shift-types";
import { ShiftBadge } from "@/components/shift-badge";
import { Button } from "@/components/ui/button";
import {
  Sheet,
  SheetContent,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet";
import { Plus, GripVertical, Pencil, Trash2, ArrowLeft } from "lucide-react";
import Link from "next/link";
import type { ShiftType } from "@/types";

const DEFAULT_COLORS = [
  { color: "#0064FF", bgColor: "#E8F0FE" },
  { color: "#FF9100", bgColor: "#FFF3E0" },
  { color: "#6C5CE7", bgColor: "#F0EDFF" },
  { color: "#94A3B8", bgColor: "#F1F5F9" },
  { color: "#00B894", bgColor: "#E6F9F3" },
  { color: "#FF3B30", bgColor: "#FFE5E5" },
];

export default function ShiftTypesPage() {
  const queryClient = useQueryClient();
  const [editingShift, setEditingShift] = useState<ShiftType | null>(null);
  const [sheetOpen, setSheetOpen] = useState(false);

  const { data: shiftTypes = [] } = useQuery({
    queryKey: ["shift-types"],
    queryFn: getShiftTypes,
  });

  const createMut = useMutation({
    mutationFn: createShiftType,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["shift-types"] });
      setSheetOpen(false);
    },
  });

  const updateMut = useMutation({
    mutationFn: ({ id, ...data }: ShiftType) => updateShiftType(id, data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ["shift-types"] });
      setSheetOpen(false);
      setEditingShift(null);
    },
  });

  const deleteMut = useMutation({
    mutationFn: deleteShiftType,
    onSuccess: () =>
      queryClient.invalidateQueries({ queryKey: ["shift-types"] }),
  });

  const openCreate = () => {
    setEditingShift(null);
    setSheetOpen(true);
  };

  const openEdit = (shift: ShiftType) => {
    setEditingShift(shift);
    setSheetOpen(true);
  };

  return (
    <div className="p-4">
      <div className="flex items-center gap-2">
        <Link
          href="/settings"
          className="flex size-10 items-center justify-center rounded-md text-text-secondary hover:bg-surface-variant"
        >
          <ArrowLeft className="size-5" />
        </Link>
        <h1 className="text-xl font-bold">근무 타입 관리</h1>
      </div>

      <div className="mt-4 space-y-2">
        {shiftTypes.map((shift) => (
          <div
            key={shift.id}
            className="flex items-center gap-3 rounded-lg border border-border-light p-3"
          >
            <GripVertical className="size-4 text-text-tertiary" />
            <ShiftBadge
              abbreviation={shift.abbreviation}
              color={shift.color}
              bgColor={shift.bgColor}
              size="md"
            />
            <div className="flex-1">
              <p className="text-sm font-medium">{shift.name}</p>
              <p className="text-xs text-text-secondary">
                {shift.startTime && shift.endTime
                  ? `${shift.startTime} ~ ${shift.endTime}`
                  : shift.category}
              </p>
            </div>
            <button
              type="button"
              onClick={() => openEdit(shift)}
              className="p-2 text-text-secondary hover:text-text-primary"
            >
              <Pencil className="size-4" />
            </button>
            <button
              type="button"
              onClick={() => {
                if (confirm(`"${shift.name}" 근무 타입을 삭제하시겠습니까?`))
                  deleteMut.mutate(shift.id);
              }}
              className="p-2 text-text-secondary hover:text-error"
            >
              <Trash2 className="size-4" />
            </button>
          </div>
        ))}
      </div>

      <Button onClick={openCreate} className="mt-4 w-full gap-1">
        <Plus className="size-4" />
        근무 타입 추가
      </Button>

      <Sheet open={sheetOpen} onOpenChange={setSheetOpen}>
        <SheetContent side="bottom" className="rounded-t-xl">
          <SheetHeader>
            <SheetTitle>
              {editingShift ? "근무 타입 수정" : "근무 타입 추가"}
            </SheetTitle>
          </SheetHeader>
          <ShiftTypeForm
            initial={editingShift}
            onSubmit={(data) => {
              if (editingShift) {
                updateMut.mutate({ ...editingShift, ...data });
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

function ShiftTypeForm({
  initial,
  onSubmit,
  isPending,
}: {
  initial: ShiftType | null;
  onSubmit: (data: Omit<ShiftType, "id">) => void;
  isPending: boolean;
}) {
  const [name, setName] = useState(initial?.name ?? "");
  const [abbreviation, setAbbreviation] = useState(
    initial?.abbreviation ?? ""
  );
  const [colorIdx, setColorIdx] = useState(() => {
    if (!initial) return 0;
    return DEFAULT_COLORS.findIndex((c) => c.color === initial.color);
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const colors = DEFAULT_COLORS[colorIdx] ?? DEFAULT_COLORS[0];
    onSubmit({
      name,
      abbreviation,
      color: colors.color,
      bgColor: colors.bgColor,
      category: "WORK",
      sortOrder: initial?.sortOrder ?? 999,
      isActive: true,
    });
  };

  return (
    <form onSubmit={handleSubmit} className="mt-4 space-y-4">
      <div>
        <label className="mb-1 block text-sm font-medium">이름</label>
        <input
          value={name}
          onChange={(e) => setName(e.target.value)}
          placeholder="예: 오전 근무"
          required
          className="w-full rounded-md border border-border bg-surface-variant px-3 py-2 text-sm outline-none focus:border-primary"
        />
      </div>
      <div>
        <label className="mb-1 block text-sm font-medium">약어</label>
        <input
          value={abbreviation}
          onChange={(e) => setAbbreviation(e.target.value)}
          placeholder="예: 오전"
          required
          className="w-full rounded-md border border-border bg-surface-variant px-3 py-2 text-sm outline-none focus:border-primary"
        />
      </div>
      <div>
        <label className="mb-1 block text-sm font-medium">색상</label>
        <div className="flex gap-2">
          {DEFAULT_COLORS.map((c, i) => (
            <button
              key={i}
              type="button"
              onClick={() => setColorIdx(i)}
              className="size-8 rounded-full ring-offset-2 transition-all"
              style={{
                backgroundColor: c.color,
                ...(i === colorIdx
                  ? { boxShadow: `0 0 0 2px ${c.color}` }
                  : {}),
              }}
            />
          ))}
        </div>
      </div>
      <Button type="submit" disabled={isPending} className="w-full">
        {isPending ? "저장 중..." : "저장"}
      </Button>
    </form>
  );
}
