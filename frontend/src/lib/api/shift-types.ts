import type { ShiftType } from "@/types";
import apiClient from "./client";

/** Worker/Manager 공용 — 활성 근무타입만 반환 */
export async function getActiveShiftTypes(): Promise<ShiftType[]> {
  const { data } = await apiClient.get("/shift-types");
  return data;
}

/** Manager 전용 — 전체 근무타입(비활성 포함) */
export async function getShiftTypes(
  status: string = "all"
): Promise<ShiftType[]> {
  const { data } = await apiClient.get("/manager/shift-types", {
    params: { status },
  });
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
