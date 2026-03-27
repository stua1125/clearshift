"use client";

import { useRouter } from "next/navigation";
import { useAuthStore } from "@/stores/auth-store";

export function useAuth() {
  const router = useRouter();
  const { user, isAuthenticated, login, logout } = useAuthStore();

  const handleLogout = () => {
    logout();
    router.replace("/auth");
  };

  return {
    user,
    isAuthenticated,
    isManager: user?.role === "MANAGER" || user?.role === "ADMIN",
    login,
    logout: handleLogout,
  };
}
