package com.clearshift.schedule.service;

import com.clearshift.event.entity.CalendarEvent;
import com.clearshift.event.repository.EventRepository;
import com.clearshift.schedule.dto.SharedCalendarMonthlyResponse;
import com.clearshift.schedule.dto.SharedCalendarMonthlyResponse.DayShiftSummary;
import com.clearshift.schedule.dto.SharedCalendarMonthlyResponse.EventInfo;
import com.clearshift.schedule.dto.SharedCalendarMonthlyResponse.ShiftCount;
import com.clearshift.schedule.dto.SharedCalendarWeeklyResponse;
import com.clearshift.schedule.dto.SharedCalendarWeeklyResponse.MemberWeekRow;
import com.clearshift.schedule.dto.SharedCalendarWeeklyResponse.ShiftInfo;
import com.clearshift.schedule.entity.DailyAssignment;
import com.clearshift.schedule.entity.MonthlySchedule;
import com.clearshift.schedule.entity.SubmissionStatus;
import com.clearshift.schedule.repository.ScheduleRepository;
import com.clearshift.user.entity.User;
import com.clearshift.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class SharedCalendarService {

    private final ScheduleRepository scheduleRepository;
    private final EventRepository eventRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public SharedCalendarMonthlyResponse getMonthlyView(User user, int year, int month) {
        UUID branchId = user.getBranch().getId();

        // All branch members count
        long totalMembers = userRepository.countByBranchId(branchId);

        // Submitted schedules
        List<MonthlySchedule> submitted = scheduleRepository
            .findByUserBranchIdAndYearAndMonthAndStatus(branchId, year, month, SubmissionStatus.SUBMITTED);
        int submittedCount = submitted.size();

        // Aggregate shift counts per day
        Map<Integer, Map<String, ShiftCount>> dayShiftMap = new HashMap<>();
        for (MonthlySchedule schedule : submitted) {
            for (DailyAssignment a : schedule.getAssignments()) {
                dayShiftMap
                    .computeIfAbsent(a.getDay(), k -> new LinkedHashMap<>())
                    .merge(
                        a.getShiftType().getAbbreviation(),
                        new ShiftCount(1, a.getShiftType().getColor(), a.getShiftType().getBgColor()),
                        (existing, incoming) -> new ShiftCount(
                            existing.count() + 1, existing.color(), existing.bgColor()
                        )
                    );
            }
        }

        // Build day summaries
        Map<Integer, DayShiftSummary> daySummaries = new HashMap<>();
        for (var entry : dayShiftMap.entrySet()) {
            daySummaries.put(entry.getKey(),
                new DayShiftSummary(entry.getValue(), (int) totalMembers, submittedCount));
        }

        // Events for this month
        LocalDate startOfMonth = LocalDate.of(year, month, 1);
        LocalDate endOfMonth = startOfMonth.withDayOfMonth(startOfMonth.lengthOfMonth());
        List<EventInfo> events = getEventsForRange(branchId, startOfMonth, endOfMonth);

        return new SharedCalendarMonthlyResponse(year, month, daySummaries, events);
    }

    @Transactional(readOnly = true)
    public SharedCalendarWeeklyResponse getWeeklyView(User user, int year, int month, int weekStartDay) {
        UUID branchId = user.getBranch().getId();

        // Calculate week range (7 days from weekStartDay)
        LocalDate weekStart = LocalDate.of(year, month, weekStartDay);
        LocalDate weekEnd = weekStart.plusDays(6);

        // Submitted schedules for the month
        List<MonthlySchedule> submitted = scheduleRepository
            .findByUserBranchIdAndYearAndMonthAndStatus(branchId, year, month, SubmissionStatus.SUBMITTED);

        // Build per-member week rows
        List<MemberWeekRow> members = submitted.stream()
            .map(schedule -> {
                Map<Integer, ShiftInfo> weekAssignments = new LinkedHashMap<>();
                for (DailyAssignment a : schedule.getAssignments()) {
                    int day = a.getDay();
                    if (day >= weekStartDay && day <= weekStartDay + 6) {
                        weekAssignments.put(day, new ShiftInfo(
                            a.getShiftType().getAbbreviation(),
                            a.getShiftType().getName(),
                            a.getShiftType().getColor(),
                            a.getShiftType().getBgColor()
                        ));
                    }
                }
                return new MemberWeekRow(
                    schedule.getUser().getId(),
                    schedule.getUser().getName(),
                    schedule.getUser().getProfileImageUrl(),
                    weekAssignments
                );
            })
            .sorted(Comparator.comparing(MemberWeekRow::userName))
            .toList();

        // Events for the week
        List<SharedCalendarMonthlyResponse.EventInfo> events = getEventsForRange(branchId, weekStart, weekEnd);

        return new SharedCalendarWeeklyResponse(year, month, weekStartDay, members, events);
    }

    private List<EventInfo> getEventsForRange(UUID branchId, LocalDate start, LocalDate end) {
        return eventRepository
            .findByBranchIdAndStartDateLessThanEqualAndEndDateGreaterThanEqualOrderByStartDateAsc(
                branchId, end, start)
            .stream()
            .map(e -> new EventInfo(e.getId(), e.getTitle(), e.getStartDate(), e.getEndDate(), e.getColor(), e.getMemo()))
            .toList();
    }
}
