package com.clearshift.schedule.dto;

import com.clearshift.schedule.entity.SubmissionStatus;
import jakarta.validation.constraints.NotNull;

public record StatusUpdateRequest(
    @NotNull SubmissionStatus status
) {}
