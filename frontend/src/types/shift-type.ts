export type ShiftCategory = "WORK" | "OFF" | "VACATION" | "TRAINING";

export interface ShiftType {
  id: string;
  name: string;
  abbreviation: string;
  color: string;
  bgColor: string;
  category: ShiftCategory;
  sortOrder: number;
  active: boolean;
  startTime?: string;
  endTime?: string;
}
