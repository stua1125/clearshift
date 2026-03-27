import type { ScheduleResponse, AssignmentRequest } from "@/types";
import apiClient from "./client";

export async function getSchedule(
  year: number,
  month: number
): Promise<ScheduleResponse> {
  const { data } = await apiClient.get(`/schedules/${year}/${month}`);
  return data;
}

export async function saveAssignments(
  year: number,
  month: number,
  req: AssignmentRequest
): Promise<ScheduleResponse> {
  const { data } = await apiClient.put(
    `/schedules/${year}/${month}/assignments`,
    req
  );
  return data;
}

export async function submitSchedule(
  year: number,
  month: number
): Promise<ScheduleResponse> {
  const { data } = await apiClient.post(`/schedules/${year}/${month}/submit`);
  return data;
}
