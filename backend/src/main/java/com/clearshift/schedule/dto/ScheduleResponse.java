package com.clearshift.schedule.dto;

import com.clearshift.schedule.entity.MonthlySchedule;
import com.clearshift.schedule.entity.SubmissionStatus;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

public record ScheduleResponse(
    UUID id,
    int year,
    int month,
    SubmissionStatus status,
    Map<Integer, AssignmentInfo> assignments,
    LocalDateTime submittedAt
) {
    public record AssignmentInfo(
        UUID shiftTypeId,
        String shiftTypeName,
        String abbreviation,
        String color,
        String bgColor
    ) {}

    public static ScheduleResponse from(MonthlySchedule schedule) {
        var assignments = schedule.getAssignments().stream()
            .collect(Collectors.toMap(
                a -> a.getDay(),
                a -> new AssignmentInfo(
                    a.getShiftType().getId(),
                    a.getShiftType().getName(),
                    a.getShiftType().getAbbreviation(),
                    a.getShiftType().getColor(),
                    a.getShiftType().getBgColor()
                )
            ));

        return new ScheduleResponse(
            schedule.getId(),
            schedule.getYear(),
            schedule.getMonth(),
            schedule.getStatus(),
            assignments,
            schedule.getSubmittedAt()
        );
    }
}
