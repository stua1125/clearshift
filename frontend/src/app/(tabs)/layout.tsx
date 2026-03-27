import { BottomNav } from "@/components/bottom-nav";
import { AuthGuard } from "@/components/auth-guard";

export default function TabsLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <AuthGuard>
      <div className="mx-auto min-h-dvh max-w-lg pb-20">
        {children}
        <BottomNav />
      </div>
    </AuthGuard>
  );
}
