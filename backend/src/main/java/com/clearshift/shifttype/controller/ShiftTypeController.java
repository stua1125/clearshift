package com.clearshift.shifttype.controller;

import com.clearshift.shifttype.entity.ShiftType;
import com.clearshift.shifttype.service.ShiftTypeService;
import com.clearshift.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/manager/shift-types")
@RequiredArgsConstructor
public class ShiftTypeController {

    private final ShiftTypeService shiftTypeService;

    @GetMapping
    public ResponseEntity<List<ShiftType>> list(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(shiftTypeService.getShiftTypes(user));
    }

    @PostMapping
    public ResponseEntity<ShiftType> create(@AuthenticationPrincipal User user,
                                             @RequestBody ShiftType shiftType) {
        return ResponseEntity.ok(shiftTypeService.create(user, shiftType));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ShiftType> update(@AuthenticationPrincipal User user,
                                             @PathVariable UUID id,
                                             @RequestBody ShiftType shiftType) {
        return ResponseEntity.ok(shiftTypeService.update(user, id, shiftType));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable UUID id) {
        shiftTypeService.delete(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/reorder")
    public ResponseEntity<Void> reorder(@AuthenticationPrincipal User user,
                                         @RequestBody List<UUID> orderedIds) {
        shiftTypeService.reorder(user, orderedIds);
        return ResponseEntity.ok().build();
    }
}
