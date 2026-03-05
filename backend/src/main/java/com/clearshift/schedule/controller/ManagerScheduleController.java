package com.clearshift.schedule.controller;

import com.clearshift.schedule.dto.StatusUpdateRequest;
import com.clearshift.schedule.dto.TeamScheduleResponse;
import com.clearshift.schedule.service.ScheduleService;
import com.clearshift.user.entity.User;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/manager")
@RequiredArgsConstructor
public class ManagerScheduleController {

    private final ScheduleService scheduleService;

    @GetMapping("/team/schedules")
    public ResponseEntity<List<TeamScheduleResponse>> getTeamSchedules(
            @AuthenticationPrincipal User user,
            @RequestParam int year,
            @RequestParam int month) {
        return ResponseEntity.ok(scheduleService.getTeamSchedules(user, year, month));
    }

    @PatchMapping("/schedules/{id}/status")
    public ResponseEntity<Void> updateStatus(
            @AuthenticationPrincipal User user,
            @PathVariable UUID id,
            @Valid @RequestBody StatusUpdateRequest request) {
        scheduleService.updateScheduleStatus(user, id, request.status());
        return ResponseEntity.ok().build();
    }
}
