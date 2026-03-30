import { create } from "zustand";
import type { AssignmentInfo } from "@/types";

interface PaintState {
  selectedShiftTypeId: string | null;
  eraserActive: boolean;
  assignments: Record<number, AssignmentInfo>;
  selectShiftType: (id: string | null) => void;
  toggleEraser: () => void;
  assignDay: (day: number, info: AssignmentInfo) => void;
  clearDay: (day: number) => void;
  setAssignments: (assignments: Record<number, AssignmentInfo>) => void;
  resetPaint: () => void;
}

export const usePaintStore = create<PaintState>()((set) => ({
  selectedShiftTypeId: null,
  eraserActive: false,
  assignments: {},
  selectShiftType: (id) => set({ selectedShiftTypeId: id, eraserActive: false }),
  toggleEraser: () =>
    set((s) => ({
      eraserActive: !s.eraserActive,
      selectedShiftTypeId: null,
    })),
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
    set({ selectedShiftTypeId: null, eraserActive: false, assignments: {} }),
}));
