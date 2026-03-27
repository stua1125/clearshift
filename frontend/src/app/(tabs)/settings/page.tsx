"use client";

import Link from "next/link";
import {
  Palette,
  Umbrella,
  CalendarDays,
  Users,
  ChevronRight,
} from "lucide-react";
import { useAuth } from "@/hooks/use-auth";
import { cn } from "@/lib/utils";

const managerItems = [
  {
    href: "/settings/shift-types",
    label: "근무 타입 관리",
    icon: Palette,
    testId: "settings-shift-types",
  },
  {
    href: "/settings/vacation",
    label: "휴가 설정",
    icon: Umbrella,
    testId: "settings-vacation",
  },
  {
    href: "/settings/events",
    label: "이벤트 관리",
    icon: CalendarDays,
    testId: "settings-events",
  },
  {
    href: "/settings/team-calendar",
    label: "팀 캘린더",
    icon: Users,
    testId: "settings-team-calendar",
  },
];

export default function SettingsPage() {
  const { user, isManager, logout } = useAuth();

  return (
    <div className="p-lg">
      <h1 className="text-2xl font-bold">설정</h1>

      {/* Profile Card */}
      <div className="mt-xl rounded-lg border border-border-light p-lg">
        <div className="flex items-center gap-md">
          <div className="flex size-12 items-center justify-center rounded-full bg-primary-container text-lg font-bold text-primary">
            {user?.name?.[0] ?? "?"}
          </div>
          <div>
            <p className="font-semibold text-text-primary">
              {user?.name ?? "로그인 필요"}
            </p>
            <p className="text-sm text-text-secondary">{user?.email}</p>
            {user?.branch && (
              <p className="text-xs text-text-tertiary">
                {user.branch.name} · {user.role}
              </p>
            )}
          </div>
        </div>
      </div>

      {/* Manager Section */}
      {isManager && (
        <div className="mt-xl">
          <h2 className="mb-sm text-sm font-semibold text-text-secondary">
            관리자 메뉴
          </h2>
          <div className="divide-y divide-border-light rounded-lg border border-border-light">
            {managerItems.map(({ href, label, icon: Icon, testId }) => (
              <Link
                key={href}
                href={href}
                data-testid={testId}
                className="flex items-center justify-between px-lg py-md transition-colors hover:bg-surface-variant"
              >
                <div className="flex items-center gap-md">
                  <Icon className="size-5 text-text-secondary" />
                  <span className="text-sm font-medium text-text-primary">
                    {label}
                  </span>
                </div>
                <ChevronRight className="size-4 text-text-tertiary" />
              </Link>
            ))}
          </div>
        </div>
      )}

      {/* Logout */}
      {user && (
        <button
          type="button"
          onClick={logout}
          className={cn(
            "mt-xl w-full rounded-lg border border-border-light px-lg py-md text-sm font-medium text-error transition-colors hover:bg-surface-variant"
          )}
        >
          로그아웃
        </button>
      )}
    </div>
  );
}
