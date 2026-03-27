export interface BranchInfo {
  id: string;
  name: string;
}

export interface AppUser {
  id: string;
  email: string;
  name: string;
  role: "ADMIN" | "MANAGER" | "WORKER";
  profileImageUrl?: string;
  branch?: BranchInfo;
}

export interface AuthResponse {
  accessToken: string;
  refreshToken: string;
  user: AppUser;
}

export interface NeedsRegistrationResponse {
  needsRegistration: true;
}

export interface GoogleLoginRequest {
  idToken: string;
}

export interface RegisterRequest {
  idToken: string;
  name: string;
  branchId: string;
}

export interface RefreshRequest {
  refreshToken: string;
}
