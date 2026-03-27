import type {
  AuthResponse,
  GoogleLoginRequest,
  RegisterRequest,
  RefreshRequest,
  AppUser,
  BranchInfo,
  NeedsRegistrationResponse,
} from "@/types";
import apiClient from "./client";

export async function googleLogin(
  req: GoogleLoginRequest
): Promise<AuthResponse | NeedsRegistrationResponse> {
  const { data } = await apiClient.post("/auth/google", req);
  return data;
}

export async function register(req: RegisterRequest): Promise<AuthResponse> {
  const { data } = await apiClient.post("/auth/register", req);
  return data;
}

export async function refreshToken(
  req: RefreshRequest
): Promise<AuthResponse> {
  const { data } = await apiClient.post("/auth/refresh", req);
  return data;
}

export async function getMe(): Promise<AppUser> {
  const { data } = await apiClient.get("/auth/me");
  return data;
}

export async function getBranches(): Promise<BranchInfo[]> {
  const { data } = await apiClient.get("/branches");
  return data;
}
