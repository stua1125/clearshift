package com.clearshift.shifttype.controller;

import com.clearshift.shifttype.entity.ShiftType;
import com.clearshift.shifttype.service.ShiftTypeService;
import com.clearshift.user.entity.User;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@Tag(name = "근무타입", description = "매니저 근무타입 CRUD + 순서 변경")
@RestController
@RequestMapping("/api/manager/shift-types")
@RequiredArgsConstructor
public class ShiftTypeController {

    private final ShiftTypeService shiftTypeService;

    @Operation(summary = "근무타입 목록 조회",
            description = "매니저 소속 지점의 전체 근무타입을 sortOrder 순으로 반환합니다.")
    @GetMapping
    public ResponseEntity<List<ShiftType>> list(@AuthenticationPrincipal User user) {
        return ResponseEntity.ok(shiftTypeService.getShiftTypes(user));
    }

    @Operation(summary = "근무타입 생성",
            description = "새 근무타입을 생성합니다. name, abbreviation(1~3자), color, bgColor, category 필수.")
    @PostMapping
    public ResponseEntity<ShiftType> create(@AuthenticationPrincipal User user,
                                             @RequestBody ShiftType shiftType) {
        return ResponseEntity.ok(shiftTypeService.create(user, shiftType));
    }

    @Operation(summary = "근무타입 수정",
            description = "기존 근무타입의 이름, 약어, 색상, 카테고리를 수정합니다.")
    @PutMapping("/{id}")
    public ResponseEntity<ShiftType> update(@AuthenticationPrincipal User user,
                                             @Parameter(description = "근무타입 ID") @PathVariable UUID id,
                                             @RequestBody ShiftType shiftType) {
        return ResponseEntity.ok(shiftTypeService.update(user, id, shiftType));
    }

    @Operation(summary = "근무타입 삭제 (소프트)",
            description = "근무타입을 비활성화합니다. 실제 삭제가 아닌 isActive=false 처리.")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @Parameter(description = "근무타입 ID") @PathVariable UUID id) {
        shiftTypeService.delete(id);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "근무타입 순서 변경",
            description = "근무타입 ID 배열을 순서대로 전달하면 sortOrder가 갱신됩니다.")
    @PutMapping("/reorder")
    public ResponseEntity<Void> reorder(@AuthenticationPrincipal User user,
                                         @RequestBody List<UUID> orderedIds) {
        shiftTypeService.reorder(user, orderedIds);
        return ResponseEntity.ok().build();
    }
}
