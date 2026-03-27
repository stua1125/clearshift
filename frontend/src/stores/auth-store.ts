import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { AppUser } from "@/types";

interface AuthState {
  user: AppUser | null;
  accessToken: string | null;
  refreshToken: string | null;
  isAuthenticated: boolean;
  login: (user: AppUser, accessToken: string, refreshToken: string) => void;
  logout: () => void;
  updateUser: (user: AppUser) => void;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      user: null,
      accessToken: null,
      refreshToken: null,
      isAuthenticated: false,
      login: (user, accessToken, refreshToken) =>
        set({ user, accessToken, refreshToken, isAuthenticated: true }),
      logout: () =>
        set({
          user: null,
          accessToken: null,
          refreshToken: null,
          isAuthenticated: false,
        }),
      updateUser: (user) => set({ user }),
    }),
    { name: "auth-storage" }
  )
);
