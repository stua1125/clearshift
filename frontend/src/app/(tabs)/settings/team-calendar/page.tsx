"use client";

import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { getTeamSchedules } from "@/lib/api/manager";
import { useCalendar } from "@/hooks/use-calendar";
import { CalendarHeader } from "@/components/calendar-header";
import { ViewToggle } from "@/components/view-toggle";
import { ArrowLeft } from "lucide-react";
import Link from "next/link";
import { TeamMonthlyView } from "./_components/team-monthly-view";
import { TeamWeeklyView } from "./_components/team-weekly-view";

export default function TeamCalendarPage() {
  const calendar = useCalendar();
  const [viewMode, setViewMode] = useState<"monthly" | "weekly">("monthly");

  const { data: schedules = [] } = useQuery({
    queryKey: ["team-schedules", calendar.year, calendar.month],
    queryFn: () => getTeamSchedules(calendar.year, calendar.month),
  });

  return (
    <div>
      <div className="flex items-center gap-sm px-lg pt-lg">
        <Link
          href="/settings"
          className="flex size-10 items-center justify-center rounded-md text-text-secondary hover:bg-surface-variant"
        >
          <ArrowLeft className="size-5" />
        </Link>
        <h1 className="text-xl font-bold">팀 캘린더</h1>
      </div>

      <CalendarHeader
        year={calendar.year}
        month={calendar.month}
        onPrev={calendar.goToPrevMonth}
        onNext={calendar.goToNextMonth}
      >
        <ViewToggle mode={viewMode} onChange={setViewMode} />
      </CalendarHeader>

      {viewMode === "monthly" ? (
        <TeamMonthlyView schedules={schedules} />
      ) : (
        <TeamWeeklyView
          schedules={schedules}
          year={calendar.year}
          month={calendar.month}
        />
      )}
    </div>
  );
}
