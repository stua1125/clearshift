package com.clearshift.shifttype.entity;

import com.clearshift.branch.entity.Branch;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "shift_type")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShiftType {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id", nullable = false)
    @JsonIgnore
    private Branch branch;

    @NotBlank
    @Column(nullable = false, length = 50)
    private String name;

    @NotBlank
    @Size(min = 1, max = 5)
    @Column(nullable = false, length = 5)
    private String abbreviation;

    @NotBlank
    @Column(nullable = false, length = 10)
    private String color;

    @NotBlank
    @Column(name = "bg_color", nullable = false, length = 10)
    private String bgColor;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ShiftCategory category;

    @Column(name = "sort_order", nullable = false)
    @Builder.Default
    private int sortOrder = 0;

    @Column(name = "start_time", length = 5)
    private String startTime;

    @Column(name = "end_time", length = 5)
    private String endTime;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private boolean isActive = true;

    @Column(name = "created_at", nullable = false, updatable = false)
    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();
}
