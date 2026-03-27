import { create } from "zustand";
import type { AssignmentInfo } from "@/types";

interface PaintState {
  paintMode: boolean;
  selectedShiftTypeId: string | null;
  assignments: Record<number, AssignmentInfo>;
  togglePaintMode: () => void;
  setPaintMode: (on: boolean) => void;
  selectShiftType: (id: string | null) => void;
  assignDay: (day: number, info: AssignmentInfo) => void;
  clearDay: (day: number) => void;
  setAssignments: (assignments: Record<number, AssignmentInfo>) => void;
  resetPaint: () => void;
}

export const usePaintStore = create<PaintState>()((set) => ({
  paintMode: false,
  selectedShiftTypeId: null,
  assignments: {},
  togglePaintMode: () =>
    set((s) => ({ paintMode: !s.paintMode })),
  setPaintMode: (on) => set({ paintMode: on }),
  selectShiftType: (id) => set({ selectedShiftTypeId: id }),
  assignDay: (day, info) =>
    set((s) => ({
      assignments: { ...s.assignments, [day]: info },
    })),
  clearDay: (day) =>
    set((s) => {
      const next = { ...s.assignments };
      delete next[day];
      return { assignments: next };
    }),
  setAssignments: (assignments) => set({ assignments }),
  resetPaint: () =>
    set({ paintMode: false, selectedShiftTypeId: null, assignments: {} }),
}));
