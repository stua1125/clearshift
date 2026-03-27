import type { CalendarEvent } from "@/types";
import apiClient from "./client";

export async function getEvents(
  year: number,
  month: number
): Promise<CalendarEvent[]> {
  const { data } = await apiClient.get("/manager/events", {
    params: { year, month },
  });
  return data;
}

export async function createEvent(
  req: Omit<CalendarEvent, "id" | "createdAt">
): Promise<CalendarEvent> {
  const { data } = await apiClient.post("/manager/events", req);
  return data;
}

export async function updateEvent(
  id: string,
  req: Partial<CalendarEvent>
): Promise<CalendarEvent> {
  const { data } = await apiClient.put(`/manager/events/${id}`, req);
  return data;
}

export async function deleteEvent(id: string): Promise<void> {
  await apiClient.delete(`/manager/events/${id}`);
}
