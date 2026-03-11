package com.clearshift.shifttype.service;

import com.clearshift.shifttype.entity.ShiftType;
import com.clearshift.shifttype.repository.ShiftTypeRepository;
import com.clearshift.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ShiftTypeService {

    private final ShiftTypeRepository shiftTypeRepository;

    public List<ShiftType> getShiftTypes(User manager) {
        return shiftTypeRepository.findByBranchIdOrderBySortOrder(manager.getBranch().getId());
    }

    public List<ShiftType> getShiftTypesByStatus(User manager, String status) {
        UUID branchId = manager.getBranch().getId();
        return switch (status) {
            case "active" -> shiftTypeRepository.findByBranchIdAndIsActiveTrueOrderBySortOrder(branchId);
            case "inactive" -> shiftTypeRepository.findByBranchIdAndIsActiveFalseOrderBySortOrder(branchId);
            default -> shiftTypeRepository.findByBranchIdOrderBySortOrder(branchId);
        };
    }

    @Transactional
    public ShiftType create(User manager, ShiftType shiftType) {
        shiftType.setBranch(manager.getBranch());
        return shiftTypeRepository.save(shiftType);
    }

    @Transactional
    public ShiftType update(User manager, UUID id, ShiftType updated) {
        ShiftType existing = shiftTypeRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        existing.setName(updated.getName());
        existing.setAbbreviation(updated.getAbbreviation());
        existing.setColor(updated.getColor());
        existing.setBgColor(updated.getBgColor());
        existing.setCategory(updated.getCategory());
        existing.setStartTime(updated.getStartTime());
        existing.setEndTime(updated.getEndTime());
        return shiftTypeRepository.save(existing);
    }

    @Transactional
    public void delete(User user, UUID id) {
        ShiftType shiftType = shiftTypeRepository.findById(id)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        if (!shiftType.getBranch().getId().equals(user.getBranch().getId())) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Access denied: shift type belongs to another branch");
        }

        shiftType.setActive(false);
        shiftTypeRepository.save(shiftType);
    }

    @Transactional
    public void reorder(User manager, List<UUID> orderedIds) {
        for (int i = 0; i < orderedIds.size(); i++) {
            ShiftType st = shiftTypeRepository.findById(orderedIds.get(i))
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
            st.setSortOrder(i);
            shiftTypeRepository.save(st);
        }
    }
}
