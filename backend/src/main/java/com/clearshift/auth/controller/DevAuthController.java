package com.clearshift.auth.controller;

import com.clearshift.auth.dto.AuthResponse;
import com.clearshift.auth.service.JwtService;
import com.clearshift.branch.repository.BranchRepository;
import com.clearshift.user.entity.Role;
import com.clearshift.user.entity.User;
import com.clearshift.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Profile;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

/**
 * 개발 환경 전용 인증 컨트롤러.
 * Google OAuth 없이 테스트용 JWT를 발급합니다.
 * -Dspring.profiles.active=dev 로 실행 시에만 활성화됩니다.
 */
@RestController
@RequestMapping("/api/dev")
@RequiredArgsConstructor
@Profile("dev")
public class DevAuthController {

    private final UserRepository userRepository;
    private final BranchRepository branchRepository;
    private final JwtService jwtService;

    /**
     * 테스트 유저 생성 + JWT 발급
     * POST /api/dev/token?role=WORKER&name=홍길동
     */
    @PostMapping("/token")
    public ResponseEntity<AuthResponse> createTestUser(
            @RequestParam(defaultValue = "WORKER") Role role,
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
