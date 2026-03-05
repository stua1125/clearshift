package com.clearshift.auth.controller;

import com.clearshift.auth.dto.AuthResponse;
import com.clearshift.auth.service.JwtService;
import com.clearshift.branch.repository.BranchRepository;
import com.clearshift.user.entity.Role;
import com.clearshift.user.entity.User;
import com.clearshift.user.repository.UserRepository;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Tag(name = "개발용", description = "dev 프로필 전용 — Google OAuth 없이 테스트 JWT 발급")
@RestController
@RequestMapping("/api/dev")
@RequiredArgsConstructor
@Profile("dev")
public class DevAuthController {

    private final UserRepository userRepository;
    private final BranchRepository branchRepository;
    private final JwtService jwtService;

    @Operation(summary = "테스트 JWT 발급",
            description = "테스트용 유저를 생성하고 JWT를 발급합니다. 발급된 accessToken을 Authorize 버튼에 입력하세요.")
    @PostMapping("/token")
    public ResponseEntity<AuthResponse> createTestUser(
            @Parameter(description = "역할 (ADMIN, MANAGER, WORKER)", example = "WORKER")
            @RequestParam(defaultValue = "WORKER") Role role,
            @Parameter(description = "사용자 이름", example = "홍길동")
            @RequestParam(defaultValue = "테스트유저") String name) {

        var branch = branchRepository.findByIsActiveTrue().stream().findFirst()
                .orElseThrow(() -> new RuntimeException("No active branch"));

        String email = name.replaceAll("\\s", "") + "-" + UUID.randomUUID().toString().substring(0, 4) + "@test.com";
        String googleId = "dev-" + UUID.randomUUID();

        User user = userRepository.findByEmail(email).orElseGet(() -> {
            User newUser = User.builder()
                    .email(email)
                    .name(name)
                    .googleId(googleId)
                    .role(role)
                    .branch(branch)
                    .build();
            return userRepository.save(newUser);
        });

        String accessToken = jwtService.generateAccessToken(user.getId(), user.getEmail(), user.getRole().name());
        String refreshToken = jwtService.generateRefreshToken(user.getId());

        return ResponseEntity.ok(new AuthResponse(
                accessToken,
                refreshToken,
                new AuthResponse.UserInfo(
                        user.getId(),
                        user.getEmail(),
                        user.getName(),
                        user.getRole().name(),
                        user.getProfileImageUrl(),
                        new AuthResponse.BranchInfo(branch.getId(), branch.getName())
                )
        ));
    }
}
