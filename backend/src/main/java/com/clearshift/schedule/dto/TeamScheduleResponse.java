package com.clearshift.schedule.dto;

import com.clearshift.schedule.entity.MonthlySchedule;
import com.clearshift.schedule.entity.SubmissionStatus;

import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

public record TeamScheduleResponse(
    UUID scheduleId,
    UUID userId,
    String userName,
    String profileImageUrl,
    SubmissionStatus status,
    Map<Integer, ScheduleResponse.AssignmentInfo> assignments
) {
    public static TeamScheduleResponse from(MonthlySchedule schedule) {
        var assignments = schedule.getAssignments().stream()
            .collect(Collectors.toMap(
                a -> a.getDay(),
                a -> new ScheduleResponse.AssignmentInfo(
                    a.getShiftType().getId(),
                    a.getShiftType().getName(),
                    a.getShiftType().getAbbreviation(),
                    a.getShiftType().getColor(),
                    a.getShiftType().getBgColor()
                )
            ));

        return new TeamScheduleResponse(
            schedule.getId(),
            schedule.getUser().getId(),
            schedule.getUser().getName(),
            schedule.getUser().getProfileImageUrl(),
            schedule.getStatus(),
            assignments
        );
    }
}
