package com.clearshift.schedule.dto;

import jakarta.validation.constraints.NotNull;

import java.util.Map;
import java.util.UUID;

public record AssignmentRequest(
    @NotNull Map<Integer, UUID> assignments  // day -> shiftTypeId
) {}
