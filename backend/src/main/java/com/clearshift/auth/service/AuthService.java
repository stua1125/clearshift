package com.clearshift.auth.service;

import com.clearshift.auth.dto.AuthResponse;
import com.clearshift.auth.dto.GoogleLoginRequest;
import com.clearshift.auth.dto.RegisterRequest;
import com.clearshift.branch.entity.Branch;
import com.clearshift.branch.repository.BranchRepository;
import com.clearshift.user.entity.User;
import com.clearshift.user.repository.UserRepository;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final BranchRepository branchRepository;
    private final JwtService jwtService;

    @Value("${google.client-id}")
    private String googleClientId;

    public Object login(GoogleLoginRequest request) {
        GoogleIdToken.Payload payload = verifyGoogleToken(request.idToken());
        String googleId = payload.getSubject();

        Optional<User> existingUser = userRepository.findByGoogleId(googleId);

        if (existingUser.isPresent()) {
            return buildAuthResponse(existingUser.get());
        }

        // User not registered yet
        return Map.of(
            "needsRegistration", true,
            "email", payload.getEmail(),
            "name", payload.get("name"),
            "profileImageUrl", payload.get("picture")
        );
    }

    public AuthResponse register(RegisterRequest request) {
        GoogleIdToken.Payload payload = verifyGoogleToken(request.idToken());
        String googleId = payload.getSubject();

        if (userRepository.findByGoogleId(googleId).isPresent()) {
            throw new ResponseStatusException(HttpStatus.CONFLICT, "User already registered");
        }

        Branch branch = branchRepository.findById(request.branchId())
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid branch"));

        User user = User.builder()
            .email(payload.getEmail())
            .name(request.name())
            .googleId(googleId)
            .profileImageUrl((String) payload.get("picture"))
            .branch(branch)
            .build();

        user = userRepository.save(user);
        return buildAuthResponse(user);
    }

    public AuthResponse refresh(String refreshToken) {
        if (!jwtService.isTokenValid(refreshToken)) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid refresh token");
        }

        var userId = jwtService.getUserIdFromToken(refreshToken);
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not found"));

        return buildAuthResponse(user);
    }

    private GoogleIdToken.Payload verifyGoogleToken(String idToken) {
        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    new NetHttpTransport(), GsonFactory.getDefaultInstance())
                .setAudience(Collections.singletonList(googleClientId))
                .build();

            GoogleIdToken token = verifier.verify(idToken);
            if (token == null) {
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid Google ID token");
            }
            return token.getPayload();
        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Failed to verify Google ID token");
        }
    }

    private AuthResponse buildAuthResponse(User user) {
        String accessToken = jwtService.generateAccessToken(user.getId(), user.getEmail(), user.getRole().name());
        String refreshToken = jwtService.generateRefreshToken(user.getId());

        AuthResponse.BranchInfo branchInfo = null;
        if (user.getBranch() != null) {
            branchInfo = new AuthResponse.BranchInfo(user.getBranch().getId(), user.getBranch().getName());
        }

        return new AuthResponse(
            accessToken,
            refreshToken,
            new AuthResponse.UserInfo(
                user.getId(),
                user.getEmail(),
                user.getName(),
                user.getRole().name(),
                user.getProfileImageUrl(),
                branchInfo
            )
        );
    }
}
