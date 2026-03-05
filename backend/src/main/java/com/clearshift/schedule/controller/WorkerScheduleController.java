package com.clearshift.schedule.controller;

import com.clearshift.schedule.dto.AssignmentRequest;
import com.clearshift.schedule.dto.ScheduleResponse;
import com.clearshift.schedule.service.ScheduleService;
import com.clearshift.user.entity.User;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/schedules")
@RequiredArgsConstructor
public class WorkerScheduleController {

    private final ScheduleService scheduleService;

    @GetMapping("/{year}/{month}")
    public ResponseEntity<ScheduleResponse> getSchedule(
            @AuthenticationPrincipal User user,
            @PathVariable int year,
            @PathVariable int month) {
        return ResponseEntity.ok(scheduleService.getSchedule(user, year, month));
    }

    @PutMapping("/{year}/{month}/assignments")
    public ResponseEntity<ScheduleResponse> saveAssignments(
            @AuthenticationPrincipal User user,
            @PathVariable int year,
            @PathVariable int month,
            @Valid @RequestBody AssignmentRequest request) {
        return ResponseEntity.ok(scheduleService.saveAssignments(user, year, month, request));
    }

    @PostMapping("/{year}/{month}/submit")
    public ResponseEntity<ScheduleResponse> submit(
            @AuthenticationPrincipal User user,
            @PathVariable int year,
            @PathVariable int month) {
        return ResponseEntity.ok(scheduleService.submitSchedule(user, year, month));
    }
}
