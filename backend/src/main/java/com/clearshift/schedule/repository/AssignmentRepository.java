package com.clearshift.schedule.repository;

import com.clearshift.schedule.entity.DailyAssignment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface AssignmentRepository extends JpaRepository<DailyAssignment, UUID> {
}
