import type { ShiftType } from "@/types";
import apiClient from "./client";

export async function getShiftTypes(): Promise<ShiftType[]> {
  const { data } = await apiClient.get("/shift-types");
  return data;
}

export async function createShiftType(
  req: Omit<ShiftType, "id">
): Promise<ShiftType> {
  const { data } = await apiClient.post("/shift-types", req);
  return data;
}

export async function updateShiftType(
  id: string,
  req: Partial<ShiftType>
): Promise<ShiftType> {
  const { data } = await apiClient.put(`/shift-types/${id}`, req);
  return data;
}

export async function deleteShiftType(id: string): Promise<void> {
  await apiClient.delete(`/shift-types/${id}`);
}

export async function reorderShiftTypes(
  ids: string[]
): Promise<ShiftType[]> {
  const { data } = await apiClient.put("/shift-types/reorder", { ids });
  return data;
}
