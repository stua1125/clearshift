package com.clearshift.event.repository;

import com.clearshift.event.entity.CalendarEvent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public interface EventRepository extends JpaRepository<CalendarEvent, UUID> {
    List<CalendarEvent> findByBranchIdOrderByStartDateAsc(UUID branchId);
    List<CalendarEvent> findByBranchIdAndStartDateLessThanEqualAndEndDateGreaterThanEqualOrderByStartDateAsc(
        UUID branchId, LocalDate endOfMonth, LocalDate startOfMonth);
}
