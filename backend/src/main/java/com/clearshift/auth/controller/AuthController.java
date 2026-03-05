package com.clearshift.auth.controller;

import com.clearshift.auth.dto.*;
import com.clearshift.auth.service.AuthService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@Tag(name = "인증", description = "Google OAuth 로그인 / 회원가입 / JWT 갱신")
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @Operation(summary = "Google 로그인",
            description = "Google ID Token으로 로그인합니다. 기존 회원이면 JWT를 반환하고, 미가입이면 needsRegistration: true를 반환합니다.")
    @PostMapping("/google")
    public ResponseEntity<?> googleLogin(@Valid @RequestBody GoogleLoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @Operation(summary = "회원가입",
            description = "Google ID Token + 이름 + 지점ID로 신규 회원가입 후 JWT를 반환합니다.")
    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@Valid @RequestBody RegisterRequest request) {
        return ResponseEntity.ok(authService.register(request));
    }

    @Operation(summary = "토큰 갱신",
            description = "Refresh Token으로 새 Access Token을 발급합니다.")
    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest request) {
        return ResponseEntity.ok(authService.refresh(request.refreshToken()));
    }

    @Operation(summary = "내 정보 조회",
            description = "현재 로그인된 사용자의 정보를 반환합니다.")
    @SecurityRequirement(name = "Bearer Token")
    @GetMapping("/me")
    public ResponseEntity<?> me(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(new AuthResponse.UserInfo(
            user.getId(),
            user.getEmail(),
            user.getName(),
            user.getRole().name(),
            user.getProfileImageUrl(),
            user.getBranch() != null
                ? new AuthResponse.BranchInfo(user.getBranch().getId(), user.getBranch().getName())
                : null
        ));
    }
}
