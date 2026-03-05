package com.clearshift.schedule.controller;

import com.clearshift.schedule.dto.SharedCalendarMonthlyResponse;
import com.clearshift.schedule.dto.SharedCalendarWeeklyResponse;
import com.clearshift.schedule.service.SharedCalendarService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@Tag(name = "공유 캘린더", description = "지점 전체 공유 캘린더 (월간/주간)")
@RestController
@RequestMapping("/api/branch/calendar")
@RequiredArgsConstructor
public class SharedCalendarController {

    private final SharedCalendarService sharedCalendarService;

    @Operation(summary = "월간 공유 캘린더",
            description = "일별 근무타입 인원 수 집계 + 이벤트를 반환합니다.")
    @GetMapping("/monthly")
    public ResponseEntity<SharedCalendarMonthlyResponse> monthly(
            @AuthenticationPrincipal User user,
            @Parameter(description = "연도", example = "2026") @RequestParam int year,
            @Parameter(description = "월 (1~12)", example = "3") @RequestParam int month) {
        return ResponseEntity.ok(sharedCalendarService.getMonthlyView(user, year, month));
    }

    @Operation(summary = "주간 공유 캘린더",
            description = "인원별 7일 근무배정 + 이벤트를 반환합니다.")
    @GetMapping("/weekly")
    public ResponseEntity<SharedCalendarWeeklyResponse> weekly(
            @AuthenticationPrincipal User user,
            @Parameter(description = "연도", example = "2026") @RequestParam int year,
            @Parameter(description = "월 (1~12)", example = "3") @RequestParam int month,
            @Parameter(description = "주 시작일 (해당 월의 날짜)", example = "1") @RequestParam int weekStart) {
        return ResponseEntity.ok(sharedCalendarService.getWeeklyView(user, year, month, weekStart));
    }
}
