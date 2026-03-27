"use client";

import { useState, useMemo } from "react";
import { useQuery } from "@tanstack/react-query";
import { getWeeklyCalendar } from "@/lib/api/calendar";
import { getWeekRows } from "@/lib/utils/calendar";
import { getWeekdayHeaders } from "@/lib/utils/format";
import { ShiftBadge } from "@/components/shift-badge";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { cn } from "@/lib/utils";

interface SharedWeeklyViewProps {
  year: number;
  month: number;
}

export function SharedWeeklyView({ year, month }: SharedWeeklyViewProps) {
  const weekRows = useMemo(() => getWeekRows(year, month), [year, month]);
  const [weekIdx, setWeekIdx] = useState(0);
  const headers = getWeekdayHeaders();

  const currentWeek = weekRows[weekIdx] ?? weekRows[0];
  const weekStart = currentWeek?.find((d) => d > 0) ?? 1;

  const { data } = useQuery({
    queryKey: ["shared-calendar", "weekly", year, month, weekStart],
    queryFn: () => getWeeklyCalendar(year, month, weekStart),
  });

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
            {data?.members.map((member) => (
              <tr
                key={member.userId}
                className="border-b border-border-light last:border-0"
              >
                <td className="px-2 py-2 font-medium text-text-primary">
                  {member.userName}
                </td>
                {currentWeek.map((day, i) => {
                  const shift = day > 0 ? member.assignments[day] : undefined;
                  return (
                    <td key={i} className="px-1 py-2 text-center">
                      {shift && (
                        <ShiftBadge
                          abbreviation={shift.abbreviation}
                          color={shift.color}
                          bgColor={shift.bgColor}
                          size="md"
                        />
                      )}
                    </td>
                  );
                })}
              </tr>
            ))}
            {(!data || data.members.length === 0) && (
              <tr>
                <td
                  colSpan={8}
                  className="py-8 text-center text-sm text-text-secondary"
                >
                  데이터가 없습니다
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
