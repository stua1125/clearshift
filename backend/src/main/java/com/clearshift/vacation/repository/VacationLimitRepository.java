package com.clearshift.vacation.repository;

import com.clearshift.vacation.entity.VacationLimit;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;
import java.util.UUID;

public interface VacationLimitRepository extends JpaRepository<VacationLimit, UUID> {
    Optional<VacationLimit> findByBranchId(UUID branchId);
}
