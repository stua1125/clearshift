package com.clearshift.auth.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.util.UUID;

public record RegisterRequest(
    @NotBlank String idToken,
    @NotBlank String name,
    @NotNull UUID branchId
) {}
