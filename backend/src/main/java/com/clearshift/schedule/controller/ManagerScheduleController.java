package com.clearshift.schedule.controller;

import com.clearshift.schedule.dto.TeamScheduleResponse;
import com.clearshift.schedule.service.ScheduleService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Tag(name = "Manager 스케줄", description = "매니저 팀 스케줄 조회")
@RestController
@RequestMapping("/api/manager")
@RequiredArgsConstructor
public class ManagerScheduleController {

    private final ScheduleService scheduleService;

    @Operation(summary = "팀 전체 스케줄 조회",
            description = "매니저 소속 지점의 모든 팀원 스케줄을 조회합니다.")
    @GetMapping("/team/schedules")
    public ResponseEntity<List<TeamScheduleResponse>> getTeamSchedules(
            @AuthenticationPrincipal User user,
            @Parameter(description = "연도", example = "2026") @RequestParam int year,
            @Parameter(description = "월 (1~12)", example = "3") @RequestParam int month) {
        return ResponseEntity.ok(scheduleService.getTeamSchedules(user, year, month));
    }
}
