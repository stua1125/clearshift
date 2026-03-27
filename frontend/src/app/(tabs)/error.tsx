"use client";

import { Button } from "@/components/ui/button";

export default function TabsError({
  error,
  reset,
}: {
  error: Error;
  reset: () => void;
}) {
  return (
    <div className="flex min-h-[50vh] flex-col items-center justify-center gap-lg px-lg text-center">
      <p className="text-lg font-semibold text-error">문제가 발생했습니다</p>
      <p className="text-sm text-text-secondary">{error.message}</p>
      <Button onClick={reset} variant="outline">
        다시 시도
      </Button>
    </div>
  );
}
