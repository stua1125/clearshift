package com.clearshift.shifttype.controller;

import com.clearshift.shifttype.entity.ShiftType;
import com.clearshift.shifttype.service.ShiftTypeService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "근무타입 조회", description = "인증된 사용자라면 누구나 소속 지점의 활성 근무타입을 조회할 수 있습니다.")
@RestController
@RequestMapping("/api/shift-types")
@RequiredArgsConstructor
public class ShiftTypeReadController {

    private final ShiftTypeService shiftTypeService;

    @Operation(summary = "활성 근무타입 목록 조회",
            description = "현재 사용자 소속 지점의 활성(isActive=true) 근무타입을 sortOrder 순으로 반환합니다.")
    @GetMapping
    public ResponseEntity<List<ShiftType>> listActive(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(shiftTypeService.getShiftTypesByStatus(user, "active"));
    }
}
