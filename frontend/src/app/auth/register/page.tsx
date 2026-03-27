"use client";

import { useState, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useQuery } from "@tanstack/react-query";
import { useAuthStore } from "@/stores/auth-store";
import { register, getBranches } from "@/lib/api/auth";
import { Button } from "@/components/ui/button";

export default function RegisterPage() {
  const router = useRouter();
  const login = useAuthStore((s) => s.login);
  const [name, setName] = useState("");
  const [branchId, setBranchId] = useState("");
  const [isPending, setIsPending] = useState(false);

  const { data: branches = [] } = useQuery({
    queryKey: ["branches"],
    queryFn: getBranches,
  });

  useEffect(() => {
    if (!sessionStorage.getItem("pendingIdToken")) {
      router.replace("/auth");
    }
  }, [router]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    const idToken = sessionStorage.getItem("pendingIdToken");
    if (!idToken) return;

    setIsPending(true);
    try {
      const res = await register({ idToken, name, branchId });
      sessionStorage.removeItem("pendingIdToken");
      login(res.user, res.accessToken, res.refreshToken);
      router.replace("/home");
    } catch {
      alert("회원가입에 실패했습니다.");
    } finally {
      setIsPending(false);
    }
  };

  return (
    <div className="flex min-h-dvh flex-col items-center justify-center px-lg">
      <div className="w-full max-w-sm">
        <h1 className="text-2xl font-bold">회원가입</h1>
        <p className="mt-xs text-sm text-text-secondary">
          정보를 입력해주세요
        </p>

        <form onSubmit={handleSubmit} className="mt-xl space-y-lg">
          <div>
            <label className="mb-1 block text-sm font-medium">이름</label>
            <input
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="홍길동"
              required
              className="w-full rounded-md border border-border bg-surface-variant px-md py-sm text-sm outline-none focus:border-primary"
            />
          </div>

          <div>
            <label className="mb-1 block text-sm font-medium">지점</label>
            <select
              value={branchId}
              onChange={(e) => setBranchId(e.target.value)}
              required
              className="w-full rounded-md border border-border bg-surface-variant px-md py-sm text-sm outline-none focus:border-primary"
            >
              <option value="">지점을 선택하세요</option>
              {branches.map((b) => (
                <option key={b.id} value={b.id}>
                  {b.name}
                </option>
              ))}
            </select>
          </div>

          <Button type="submit" disabled={isPending} className="w-full">
            {isPending ? "가입 중..." : "가입하기"}
          </Button>
        </form>
      </div>
    </div>
  );
}
