package com.clearshift.vacation.controller;

import com.clearshift.user.entity.User;
import com.clearshift.vacation.entity.VacationLimit;
import com.clearshift.vacation.service.VacationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/manager/vacation-limits")
@RequiredArgsConstructor
public class VacationController {

    private final VacationService vacationService;

    @GetMapping
    public ResponseEntity<VacationLimit> get(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(vacationService.getLimit(user));
    }

    @PutMapping
    public ResponseEntity<VacationLimit> updateDefault(@AuthenticationPrincipal User user,
                                                        @RequestBody Map<String, Integer> body) {
        return ResponseEntity.ok(vacationService.updateDefaultMax(user, body.get("defaultMax")));
    }

    @PostMapping("/overrides")
    public ResponseEntity<VacationLimit> addOverride(@AuthenticationPrincipal User user,
                                                      @RequestBody Map<String, Object> body) {
        LocalDate date = LocalDate.parse((String) body.get("date"));
        int maxCount = (int) body.get("maxCount");
        return ResponseEntity.ok(vacationService.addOverride(user, date, maxCount));
    }

    @DeleteMapping("/overrides/{id}")
    public ResponseEntity<Void> removeOverride(@AuthenticationPrincipal User user,
                                                @PathVariable UUID id) {
        vacationService.removeOverride(user, id);
        return ResponseEntity.ok().build();
    }
}
