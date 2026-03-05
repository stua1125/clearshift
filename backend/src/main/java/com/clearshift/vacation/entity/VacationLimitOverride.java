package com.clearshift.vacation.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "vacation_limit_override", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"vacation_limit_id", "target_date"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VacationLimitOverride {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vacation_limit_id", nullable = false)
    private VacationLimit vacationLimit;

    @Column(name = "target_date", nullable = false)
    private LocalDate targetDate;

    @Column(name = "max_count", nullable = false)
    private int maxCount;
}
