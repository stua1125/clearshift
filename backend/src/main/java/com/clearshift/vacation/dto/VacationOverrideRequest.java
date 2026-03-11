package com.clearshift.vacation.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;

public record VacationOverrideRequest(
    @NotNull LocalDate date,
    @Min(0) int maxCount
) {}
