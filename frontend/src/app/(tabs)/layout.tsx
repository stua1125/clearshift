import { BottomNav } from "@/components/bottom-nav";

export default function TabsLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="mx-auto min-h-dvh max-w-lg pb-20">
      {children}
      <BottomNav />
    </div>
  );
}
