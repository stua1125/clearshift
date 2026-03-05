package com.clearshift.user.repository;

import com.clearshift.user.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends JpaRepository<User, UUID> {
    Optional<User> findByGoogleId(String googleId);
    Optional<User> findByEmail(String email);
    List<User> findByBranchId(UUID branchId);
    long countByBranchId(UUID branchId);
}
