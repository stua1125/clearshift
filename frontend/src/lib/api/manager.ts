import type { TeamScheduleResponse } from "@/types";
import apiClient from "./client";

export async function getTeamSchedules(
  year: number,
  month: number
): Promise<TeamScheduleResponse[]> {
  const { data } = await apiClient.get("/manager/schedules", {
    params: { year, month },
  });
  return data;
}
