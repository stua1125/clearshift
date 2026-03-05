package com.clearshift.branch.controller;

import com.clearshift.branch.entity.Branch;
import com.clearshift.branch.service.BranchService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "지점", description = "지점(Branch) 목록 조회 — 인증 불필요")
@RestController
@RequestMapping("/api/branches")
@RequiredArgsConstructor
public class BranchController {

    private final BranchService branchService;

    @Operation(summary = "활성 지점 목록",
            description = "회원가입 시 선택할 수 있는 활성 지점 목록을 반환합니다.")
    @GetMapping
    public ResponseEntity<List<Branch>> list() {
        return ResponseEntity.ok(branchService.getActiveBranches());
    }
}
