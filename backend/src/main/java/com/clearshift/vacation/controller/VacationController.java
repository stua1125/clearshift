package com.clearshift.vacation.controller;

import com.clearshift.user.entity.User;
import com.clearshift.vacation.dto.VacationOverrideRequest;
import com.clearshift.vacation.entity.VacationLimit;
import com.clearshift.vacation.service.VacationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@Tag(name = "휴가 설정", description = "매니저 일일 휴가 최대 인원(MAX) 관리 + 날짜별 Override")
@RestController
@RequestMapping("/api/manager/vacation-limits")
@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
@RequiredArgsConstructor
public class VacationController {

    private final VacationService vacationService;

    @Operation(summary = "휴가 MAX 조회",
            description = "지점의 기본 MAX값과 날짜별 Override 목록을 반환합니다.")
    @GetMapping
    public ResponseEntity<VacationLimit> get(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(vacationService.getLimit(user));
    }

    @Operation(summary = "기본 MAX 수정",
            description = "일일 동시 휴가 최대 인원을 변경합니다. body: {\"defaultMax\": 5}")
    @PutMapping
    public ResponseEntity<VacationLimit> updateDefault(@AuthenticationPrincipal User user,
                                                        @RequestBody Map<String, Integer> body) {
        return ResponseEntity.ok(vacationService.updateDefaultMax(user, body.get("defaultMax")));
    }

    @Operation(summary = "날짜별 Override 추가",
            description = "특정 날짜에 다른 MAX를 적용합니다. body: {\"date\": \"2026-03-15\", \"maxCount\": 5}")
    @PostMapping("/overrides")
    public ResponseEntity<VacationLimit> addOverride(@AuthenticationPrincipal User user,
                                                      @Valid @RequestBody VacationOverrideRequest request) {
        return ResponseEntity.ok(vacationService.addOverride(user, request.date(), request.maxCount()));
    }

    @Operation(summary = "Override 삭제",
            description = "날짜별 Override를 삭제합니다. 해당 날짜는 기본 MAX로 돌아갑니다.")
    @DeleteMapping("/overrides/{id}")
    public ResponseEntity<Void> removeOverride(@AuthenticationPrincipal User user,
                                                @Parameter(description = "Override ID") @PathVariable UUID id) {
        vacationService.removeOverride(user, id);
        return ResponseEntity.ok().build();
    }
}
