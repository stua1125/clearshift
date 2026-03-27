"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuthStore } from "@/stores/auth-store";

export function ManagerGuard({ children }: { children: React.ReactNode }) {
  const router = useRouter();
  const user = useAuthStore((s) => s.user);

  const isManager = user?.role === "MANAGER" || user?.role === "ADMIN";

  useEffect(() => {
    if (user && !isManager) {
      router.replace("/settings");
    }
  }, [user, isManager, router]);

  if (!isManager) {
    return null;
  }

  return <>{children}</>;
}
