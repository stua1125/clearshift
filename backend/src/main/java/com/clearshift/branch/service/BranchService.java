package com.clearshift.branch.service;

import com.clearshift.branch.entity.Branch;
import com.clearshift.branch.repository.BranchRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class BranchService {

    private final BranchRepository branchRepository;

    public List<Branch> getActiveBranches() {
        return branchRepository.findByIsActiveTrue();
    }
}
