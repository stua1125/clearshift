"use client";

import { ShiftBadge } from "@/components/shift-badge";
import { cn } from "@/lib/utils";
import type { TeamScheduleResponse } from "@/types";

interface TeamMonthlyViewProps {
  schedules: TeamScheduleResponse[];
}

export function TeamMonthlyView({ schedules }: TeamMonthlyViewProps) {
  return (
    <div className="space-y-sm px-lg">
      {schedules.map((member) => (
        <div
          key={member.scheduleId}
          className="rounded-lg border border-border-light p-md"
        >
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-sm">
              <div className="flex size-8 items-center justify-center rounded-full bg-primary-container text-xs font-bold text-primary">
                {member.userName[0]}
              </div>
              <span className="text-sm font-medium">{member.userName}</span>
            </div>
            <span
              className={cn(
                "rounded-full px-2 py-0.5 text-[10px] font-semibold",
                member.status === "SUBMITTED"
                  ? "bg-[#E6F9F3] text-success"
                  : "bg-[#FFF3E0] text-warning"
              )}
            >
              {member.status === "SUBMITTED" ? "제출" : "미제출"}
            </span>
          </div>
          <div className="mt-sm flex flex-wrap gap-1">
            {Object.entries(member.assignments)
              .sort(([a], [b]) => Number(a) - Number(b))
              .slice(0, 10)
              .map(([day, info]) => (
                <div key={day} className="flex flex-col items-center gap-0.5">
                  <span className="text-[9px] text-text-tertiary">{day}</span>
                  <ShiftBadge
                    abbreviation={info.abbreviation}
                    color={info.color}
                    bgColor={info.bgColor}
                  />
                </div>
              ))}
            {Object.keys(member.assignments).length > 10 && (
              <span className="self-end text-[10px] text-text-tertiary">
                +{Object.keys(member.assignments).length - 10}
              </span>
            )}
          </div>
        </div>
      ))}
      {schedules.length === 0 && (
        <p className="py-8 text-center text-sm text-text-secondary">
          팀원이 없습니다
        </p>
      )}
    </div>
  );
}
