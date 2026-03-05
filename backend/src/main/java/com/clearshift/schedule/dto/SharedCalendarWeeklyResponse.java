package com.clearshift.schedule.dto;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public record SharedCalendarWeeklyResponse(
    int year,
    int month,
    int weekStartDay,
    List<MemberWeekRow> members,
    List<SharedCalendarMonthlyResponse.EventInfo> events
) {
    public record MemberWeekRow(
        UUID userId,
        String userName,
        String profileImageUrl,
        Map<Integer, ShiftInfo> assignments
    ) {}

    public record ShiftInfo(
        String abbreviation,
        String name,
        String color,
        String bgColor
    ) {}
}
