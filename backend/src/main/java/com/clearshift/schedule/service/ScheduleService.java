package com.clearshift.schedule.service;

import com.clearshift.schedule.dto.AssignmentRequest;
import com.clearshift.schedule.dto.ScheduleResponse;
import com.clearshift.schedule.dto.TeamScheduleResponse;
import com.clearshift.schedule.entity.DailyAssignment;
import com.clearshift.schedule.entity.MonthlySchedule;
import com.clearshift.schedule.entity.SubmissionStatus;
import com.clearshift.schedule.repository.ScheduleRepository;
import com.clearshift.shifttype.entity.ShiftType;
import com.clearshift.shifttype.repository.ShiftTypeRepository;
import com.clearshift.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ScheduleService {

    private final ScheduleRepository scheduleRepository;
    private final ShiftTypeRepository shiftTypeRepository;

    @Transactional(readOnly = true)
    public ScheduleResponse getSchedule(User user, int year, int month) {
        MonthlySchedule schedule = scheduleRepository
            .findByUserIdAndYearAndMonth(user.getId(), year, month)
            .orElse(null);

        if (schedule == null) {
            return new ScheduleResponse(null, year, month, SubmissionStatus.DRAFT, java.util.Map.of(), null);
        }

        return ScheduleResponse.from(schedule);
    }

    @Transactional
    public ScheduleResponse saveAssignments(User user, int year, int month, AssignmentRequest request) {
        MonthlySchedule schedule = scheduleRepository
            .findByUserIdAndYearAndMonth(user.getId(), year, month)
            .orElseGet(() -> {
                MonthlySchedule newSchedule = MonthlySchedule.builder()
                    .user(user)
                    .year(year)
                    .month(month)
                    .build();
                return scheduleRepository.save(newSchedule);
            });

        // Reset to draft when editing
        if (schedule.getStatus() != SubmissionStatus.DRAFT) {
            schedule.setStatus(SubmissionStatus.DRAFT);
        }

        // Clear existing and rebuild
        schedule.getAssignments().clear();

        for (var entry : request.assignments().entrySet()) {
            ShiftType shiftType = shiftTypeRepository.findById(entry.getValue())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid shift type"));

            DailyAssignment assignment = DailyAssignment.builder()
                .schedule(schedule)
                .day(entry.getKey())
                .shiftType(shiftType)
                .build();
            schedule.getAssignments().add(assignment);
        }

        schedule = scheduleRepository.save(schedule);
        return ScheduleResponse.from(schedule);
    }

    @Transactional
    public ScheduleResponse submitSchedule(User user, int year, int month) {
        MonthlySchedule schedule = scheduleRepository
            .findByUserIdAndYearAndMonth(user.getId(), year, month)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Schedule not found"));

        schedule.setStatus(SubmissionStatus.SUBMITTED);
        schedule.setSubmittedAt(LocalDateTime.now());
        schedule = scheduleRepository.save(schedule);
        return ScheduleResponse.from(schedule);
    }

    @Transactional(readOnly = true)
    public List<TeamScheduleResponse> getTeamSchedules(User manager, int year, int month) {
        UUID branchId = manager.getBranch().getId();
        List<MonthlySchedule> schedules = scheduleRepository
            .findByUserBranchIdAndYearAndMonth(branchId, year, month);

        return schedules.stream()
            .map(TeamScheduleResponse::from)
            .toList();
    }

}
