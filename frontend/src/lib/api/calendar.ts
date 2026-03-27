import type {
  SharedCalendarMonthlyResponse,
  SharedCalendarWeeklyResponse,
} from "@/types";
import apiClient from "./client";

export async function getMonthlyCalendar(
  year: number,
  month: number
): Promise<SharedCalendarMonthlyResponse> {
  const { data } = await apiClient.get("/branch/calendar/monthly", {
    params: { year, month },
  });
  return data;
}

export async function getWeeklyCalendar(
  year: number,
  month: number,
  weekStart: number
): Promise<SharedCalendarWeeklyResponse> {
  const { data } = await apiClient.get("/branch/calendar/weekly", {
    params: { year, month, weekStart },
  });
  return data;
}
