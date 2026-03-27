import type { AuthResponse } from "@/types";
import apiClient from "./client";

export async function getDevToken(
  role: "WORKER" | "MANAGER" | "ADMIN" = "WORKER",
  name: string = "테스트유저"
): Promise<AuthResponse> {
  const { data } = await apiClient.post("/dev/token", null, {
    params: { role, name },
  });
  return data;
}
