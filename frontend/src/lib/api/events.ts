import type { CalendarEvent } from "@/types";
import apiClient from "./client";

export async function getEvents(
  year: number,
  month: number
): Promise<CalendarEvent[]> {
  const { data } = await apiClient.get("/events", {
    params: { year, month },
  });
  return data;
}

export async function createEvent(
  req: Omit<CalendarEvent, "id" | "createdAt">
): Promise<CalendarEvent> {
  const { data } = await apiClient.post("/events", req);
  return data;
}

export async function updateEvent(
  id: string,
  req: Partial<CalendarEvent>
): Promise<CalendarEvent> {
  const { data } = await apiClient.put(`/events/${id}`, req);
  return data;
}

export async function deleteEvent(id: string): Promise<void> {
  await apiClient.delete(`/events/${id}`);
}
