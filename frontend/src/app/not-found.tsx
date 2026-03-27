import Link from "next/link";
import { Button } from "@/components/ui/button";

export default function NotFound() {
  return (
    <div className="flex min-h-dvh flex-col items-center justify-center gap-4 px-4 text-center">
      <p className="text-6xl font-bold text-text-tertiary">404</p>
      <p className="text-sm text-text-secondary">
        페이지를 찾을 수 없습니다
      </p>
      <Button asChild>
        <Link href="/home">홈으로 돌아가기</Link>
      </Button>
    </div>
  );
}
