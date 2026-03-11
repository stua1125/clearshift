package com.clearshift.event.controller;

import com.clearshift.event.entity.CalendarEvent;
import com.clearshift.event.service.EventService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Tag(name = "이벤트", description = "매니저 캘린더 이벤트 CRUD")
@RestController
@RequestMapping("/api/manager/events")
@PreAuthorize("hasRole('MANAGER') or hasRole('ADMIN')")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;

    @Operation(summary = "이벤트 목록 조회",
            description = "매니저 소속 지점의 이벤트를 시작일 오름차순으로 반환합니다. q 파라미터로 제목 검색 가능.")
    @GetMapping
    public ResponseEntity<List<CalendarEvent>> list(
            @AuthenticationPrincipal User user,
            @Parameter(description = "검색어 (제목)") @RequestParam(required = false) String q) {
        if (q != null && !q.isBlank()) {
            return ResponseEntity.ok(eventService.searchEvents(user, q.trim()));
        }
        return ResponseEntity.ok(eventService.getEvents(user));
    }

    @Operation(summary = "이벤트 생성",
            description = "새 캘린더 이벤트를 생성합니다. title, startDate, endDate, color 필수.")
    @PostMapping
    public ResponseEntity<CalendarEvent> create(@AuthenticationPrincipal User user,
                                                 @Valid @RequestBody CalendarEvent event) {
        return ResponseEntity.ok(eventService.create(user, event));
    }

    @Operation(summary = "이벤트 수정",
            description = "기존 이벤트의 제목, 날짜, 색상, 메모를 수정합니다.")
    @PutMapping("/{id}")
    public ResponseEntity<CalendarEvent> update(@AuthenticationPrincipal User user,
            @Parameter(description = "이벤트 ID") @PathVariable UUID id,
            @Valid @RequestBody CalendarEvent event) {
        return ResponseEntity.ok(eventService.update(user, id, event));
    }

    @Operation(summary = "이벤트 삭제",
            description = "이벤트를 영구 삭제합니다.")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@AuthenticationPrincipal User user,
            @Parameter(description = "이벤트 ID") @PathVariable UUID id) {
        eventService.delete(user, id);
        return ResponseEntity.ok().build();
    }
}
