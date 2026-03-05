package com.clearshift.schedule.dto;

import java.time.LocalDate;
import java.util.Map;
import java.util.UUID;

public record SharedCalendarMonthlyResponse(
    int year,
    int month,
    Map<Integer, DayShiftSummary> daySummaries,
    java.util.List<EventInfo> events
) {
    public record DayShiftSummary(
        Map<String, ShiftCount> shiftCounts,
        int totalMembers,
        int submittedCount
    ) {}

    public record ShiftCount(
        int count,
        String color,
        String bgColor
    ) {}

    public record EventInfo(
        UUID id,
        String title,
        LocalDate startDate,
        LocalDate endDate,
        String color,
        String memo
    ) {}
}
