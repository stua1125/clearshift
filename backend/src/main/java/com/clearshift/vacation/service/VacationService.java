package com.clearshift.vacation.service;

import com.clearshift.vacation.entity.VacationLimit;
import com.clearshift.vacation.entity.VacationLimitOverride;
import com.clearshift.vacation.repository.VacationLimitRepository;
import com.clearshift.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class VacationService {

    private final VacationLimitRepository vacationLimitRepository;

    public VacationLimit getLimit(User manager) {
        return vacationLimitRepository.findByBranchId(manager.getBranch().getId())
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));
    }

    @Transactional
    public VacationLimit updateDefaultMax(User manager, int defaultMax) {
        VacationLimit limit = getLimit(manager);
        limit.setDefaultMax(defaultMax);
        return vacationLimitRepository.save(limit);
    }

    @Transactional
    public VacationLimit addOverride(User manager, LocalDate date, int maxCount) {
        VacationLimit limit = getLimit(manager);
        VacationLimitOverride override = VacationLimitOverride.builder()
            .vacationLimit(limit)
            .targetDate(date)
            .maxCount(maxCount)
            .build();
        limit.getOverrides().add(override);
        return vacationLimitRepository.save(limit);
    }

    @Transactional
    public void removeOverride(User manager, UUID overrideId) {
        VacationLimit limit = getLimit(manager);
        limit.getOverrides().removeIf(o -> o.getId().equals(overrideId));
        vacationLimitRepository.save(limit);
    }
}
