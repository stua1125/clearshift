package com.clearshift.schedule.controller;

import com.clearshift.schedule.dto.AssignmentRequest;
import com.clearshift.schedule.dto.ScheduleResponse;
import com.clearshift.schedule.service.ScheduleService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@Tag(name = "Worker 스케줄", description = "근무자 월별 스케줄 조회 / 배정 저장 / 제출")
@RestController
@RequestMapping("/api/schedules")
@RequiredArgsConstructor
public class WorkerScheduleController {

    private final ScheduleService scheduleService;

    @Operation(summary = "내 월별 스케줄 조회",
            description = "로그인한 근무자의 해당 년/월 스케줄을 조회합니다. 없으면 빈 DRAFT 상태를 반환합니다.")
    @GetMapping("/{year}/{month}")
    public ResponseEntity<ScheduleResponse> getSchedule(
            @AuthenticationPrincipal User user,
            @Parameter(description = "연도", example = "2026") @PathVariable int year,
            @Parameter(description = "월 (1~12)", example = "3") @PathVariable int month) {
        return ResponseEntity.ok(scheduleService.getSchedule(user, year, month));
    }

    @Operation(summary = "일별 배정 저장",
            description = "Paint Mode에서 배정한 근무를 저장합니다. assignments는 {day: shiftTypeId} 형태입니다. 기존 배정을 전부 교체합니다.")
    @PutMapping("/{year}/{month}/assignments")
    public ResponseEntity<ScheduleResponse> saveAssignments(
            @AuthenticationPrincipal User user,
            @Parameter(description = "연도", example = "2026") @PathVariable int year,
            @Parameter(description = "월 (1~12)", example = "3") @PathVariable int month,
            @Valid @RequestBody AssignmentRequest request) {
        return ResponseEntity.ok(scheduleService.saveAssignments(user, year, month, request));
    }

    @Operation(summary = "스케줄 제출",
            description = "모든 날짜 배정 완료 후 매니저에게 제출합니다. 상태가 SUBMITTED로 변경됩니다.")
    @PostMapping("/{year}/{month}/submit")
    public ResponseEntity<ScheduleResponse> submit(
            @AuthenticationPrincipal User user,
            @Parameter(description = "연도", example = "2026") @PathVariable int year,
            @Parameter(description = "월 (1~12)", example = "3") @PathVariable int month) {
        return ResponseEntity.ok(scheduleService.submitSchedule(user, year, month));
    }
}
