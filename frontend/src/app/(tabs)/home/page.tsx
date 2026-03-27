"use client";

import { useState } from "react";
import { useCalendar } from "@/hooks/use-calendar";
import { CalendarHeader } from "@/components/calendar-header";
import { ViewToggle } from "@/components/view-toggle";
import { SharedMonthlyView } from "./_components/shared-monthly-view";
import { SharedWeeklyView } from "./_components/shared-weekly-view";

export default function HomePage() {
  const calendar = useCalendar();
  const [viewMode, setViewMode] = useState<"monthly" | "weekly">("monthly");

  return (
    <div>
      <CalendarHeader
        year={calendar.year}
        month={calendar.month}
        onPrev={calendar.goToPrevMonth}
        onNext={calendar.goToNextMonth}
      >
        <ViewToggle mode={viewMode} onChange={setViewMode} />
      </CalendarHeader>

      {viewMode === "monthly" ? (
        <SharedMonthlyView
          year={calendar.year}
          month={calendar.month}
          weekRows={calendar.weekRows}
          firstDayOfWeek={calendar.firstDayOfWeek}
          daysInMonth={calendar.daysInMonth}
        />
      ) : (
        <SharedWeeklyView
          year={calendar.year}
          month={calendar.month}
        />
      )}
    </div>
  );
}
