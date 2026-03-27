import type { ShiftType } from "@/types";
import apiClient from "./client";

export async function getShiftTypes(): Promise<ShiftType[]> {
  const { data } = await apiClient.get("/manager/shift-types");
  return data;
}

export async function createShiftType(
  req: Omit<ShiftType, "id">
): Promise<ShiftType> {
  const { data } = await apiClient.post("/manager/shift-types", req);
  return data;
}

export async function updateShiftType(
  id: string,
  req: Partial<ShiftType>
): Promise<ShiftType> {
  const { data } = await apiClient.put(`/manager/shift-types/${id}`, req);
  return data;
}

export async function deleteShiftType(id: string): Promise<void> {
  await apiClient.delete(`/manager/shift-types/${id}`);
}

export async function reorderShiftTypes(
  ids: string[]
): Promise<ShiftType[]> {
  const { data } = await apiClient.put("/manager/shift-types/reorder", { ids });
  return data;
}
