package com.clearshift.shifttype.repository;

import com.clearshift.shifttype.entity.ShiftType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface ShiftTypeRepository extends JpaRepository<ShiftType, UUID> {
    List<ShiftType> findByBranchIdAndIsActiveTrueOrderBySortOrder(UUID branchId);
    List<ShiftType> findByBranchIdAndIsActiveFalseOrderBySortOrder(UUID branchId);
    List<ShiftType> findByBranchIdOrderBySortOrder(UUID branchId);
}
