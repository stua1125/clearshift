package com.clearshift.schedule.repository;

import com.clearshift.schedule.entity.MonthlySchedule;
import com.clearshift.schedule.entity.SubmissionStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface ScheduleRepository extends JpaRepository<MonthlySchedule, UUID> {
    Optional<MonthlySchedule> findByUserIdAndYearAndMonth(UUID userId, int year, int month);
    List<MonthlySchedule> findByUserBranchIdAndYearAndMonth(UUID branchId, int year, int month);
    List<MonthlySchedule> findByUserBranchIdAndYearAndMonthAndStatus(UUID branchId, int year, int month, SubmissionStatus status);
}
