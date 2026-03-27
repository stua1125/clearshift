import type { VacationLimit, VacationOverrideRequest } from "@/types";
import apiClient from "./client";

export async function getVacationLimits(
  year: number,
  month: number
): Promise<VacationLimit> {
  const { data } = await apiClient.get("/manager/vacation-limits", {
    params: { year, month },
  });
  return data;
}

export async function updateDefaultMax(
  defaultMax: number
): Promise<VacationLimit> {
  const { data } = await apiClient.put("/manager/vacation-limits", {
    defaultMax,
  });
  return data;
}

export async function setOverride(
  req: VacationOverrideRequest
): Promise<VacationLimit> {
  const { data } = await apiClient.post("/manager/vacation-limits/overrides", req);
  return data;
}

export async function deleteOverride(id: string): Promise<VacationLimit> {
  const { data } = await apiClient.delete(
    `/manager/vacation-limits/overrides/${id}`
  );
  return data;
}
