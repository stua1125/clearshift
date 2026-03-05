package com.clearshift.vacation.entity;

import com.clearshift.branch.entity.Branch;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "vacation_limit")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VacationLimit {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "branch_id", nullable = false, unique = true)
    @JsonIgnore
    private Branch branch;

    @Column(name = "default_max", nullable = false)
    @Builder.Default
    private int defaultMax = 3;

    @OneToMany(mappedBy = "vacationLimit", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<VacationLimitOverride> overrides = new ArrayList<>();
}
