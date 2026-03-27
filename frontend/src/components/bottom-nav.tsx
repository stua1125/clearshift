"use client";

import { usePathname } from "next/navigation";
import Link from "next/link";
import { Home, CalendarDays, Settings } from "lucide-react";
import { cn } from "@/lib/utils";

const tabs = [
  { href: "/home", label: "홈", icon: Home },
  { href: "/schedule", label: "근무신청", icon: CalendarDays },
  { href: "/settings", label: "설정", icon: Settings },
] as const;

export function BottomNav() {
  const pathname = usePathname();

  return (
    <nav className="fixed inset-x-0 bottom-0 z-50 border-t border-border-light bg-surface">
      <div className="mx-auto flex h-16 max-w-lg items-stretch">
        {tabs.map(({ href, label, icon: Icon }) => {
          const isActive = pathname.startsWith(href);
          return (
            <Link
              key={href}
              href={href}
              className={cn(
                "flex flex-1 flex-col items-center justify-center gap-1 text-[10px] font-semibold transition-colors",
                isActive
                  ? "text-primary"
                  : "text-text-tertiary hover:text-text-secondary"
              )}
            >
              <div
                className={cn(
                  "flex size-8 items-center justify-center rounded-full transition-colors",
                  isActive && "bg-primary-container"
                )}
              >
                <Icon className="size-5" />
              </div>
              {label}
            </Link>
          );
        })}
      </div>
      <div className="h-[env(safe-area-inset-bottom)]" />
    </nav>
  );
}
