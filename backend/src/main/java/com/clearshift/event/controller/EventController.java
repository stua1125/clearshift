package com.clearshift.event.controller;

import com.clearshift.event.entity.CalendarEvent;
import com.clearshift.event.service.EventService;
import com.clearshift.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/manager/events")
@RequiredArgsConstructor
public class EventController {

    private final EventService eventService;

    @GetMapping
    public ResponseEntity<List<CalendarEvent>> list(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(eventService.getEvents(user));
    }

    @PostMapping
    public ResponseEntity<CalendarEvent> create(@AuthenticationPrincipal User user,
                                                 @RequestBody CalendarEvent event) {
        return ResponseEntity.ok(eventService.create(user, event));
    }

    @PutMapping("/{id}")
    public ResponseEntity<CalendarEvent> update(@PathVariable UUID id,
                                                 @RequestBody CalendarEvent event) {
        return ResponseEntity.ok(eventService.update(id, event));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        eventService.delete(id);
        return ResponseEntity.ok().build();
    }
}
