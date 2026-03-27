"use client";

import { useState, useMemo } from "react";
import { getWeekRows } from "@/lib/utils/calendar";
import { getWeekdayHeaders } from "@/lib/utils/format";
import { ShiftBadge } from "@/components/shift-badge";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { cn } from "@/lib/utils";
import type { TeamScheduleResponse } from "@/types";

interface TeamWeeklyViewProps {
  schedules: TeamScheduleResponse[];
  year: number;
  month: number;
}

export function TeamWeeklyView({
  schedules,
  year,
  month,
}: TeamWeeklyViewProps) {
  const weekRows = useMemo(() => getWeekRows(year, month), [year, month]);
  const [weekIdx, setWeekIdx] = useState(0);
  const headers = getWeekdayHeaders();
  const currentWeek = weekRows[weekIdx] ?? weekRows[0];

  return (
    <div>
      <div className="flex items-center justify-between px-lg py-sm">
        <button
          type="button"
          onClick={() => setWeekIdx((i) => Math.max(0, i - 1))}
          disabled={weekIdx === 0}
          className="flex size-8 items-center justify-center rounded-md text-text-secondary disabled:opacity-30"
        >
          <ChevronLeft className="size-4" />
        </button>
        <span className="text-sm font-medium text-text-primary">
          {month}월 {weekIdx + 1}주
        </span>
        <button
          type="button"
          onClick={() =>
            setWeekIdx((i) => Math.min(weekRows.length - 1, i + 1))
          }
          disabled={weekIdx === weekRows.length - 1}
          className="flex size-8 items-center justify-center rounded-md text-text-secondary disabled:opacity-30"
        >
          <ChevronRight className="size-4" />
        </button>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full min-w-[480px] text-xs">
          <thead>
            <tr className="border-b border-border-light">
              <th className="w-20 px-2 py-2 text-left font-medium text-text-secondary">
                이름
              </th>
              {currentWeek.map((day, i) => (
                <th
                  key={i}
                  className={cn(
                    "px-1 py-2 text-center font-medium",
                    i === 0 && "text-sunday",
                    i === 6 && "text-saturday",
                    i > 0 && i < 6 && "text-text-secondary"
                  )}
                >
                  {day > 0 ? `${headers[i]} ${day}` : ""}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {schedules.map((member) => (
              <tr
                key={member.scheduleId}
                className="border-b border-border-light last:border-0"
              >
                <td className="px-2 py-2 font-medium text-text-primary">
                  {member.userName}
                </td>
                {currentWeek.map((day, i) => {
                  const info = day > 0 ? member.assignments[day] : undefined;
                  return (
                    <td key={i} className="px-1 py-2 text-center">
                      {info && (
                        <ShiftBadge
                          abbreviation={info.abbreviation}
                          color={info.color}
                          bgColor={info.bgColor}
                          size="md"
                        />
                      )}
                    </td>
                  );
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
