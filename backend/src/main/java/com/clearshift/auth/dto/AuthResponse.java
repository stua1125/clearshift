package com.clearshift.auth.dto;

import java.util.UUID;

public record AuthResponse(
    String accessToken,
    String refreshToken,
    UserInfo user
) {
    public record UserInfo(
        UUID id,
        String email,
        String name,
        String role,
        String profileImageUrl,
        BranchInfo branch
    ) {}

    public record BranchInfo(
        UUID id,
        String name
    ) {}
}
