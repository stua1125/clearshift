package com.clearshift.schedule.entity;

import com.clearshift.shifttype.entity.ShiftType;
import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Entity
@Table(name = "daily_assignment", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"schedule_id", "day"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DailyAssignment {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "schedule_id", nullable = false)
    private MonthlySchedule schedule;

    @Column(nullable = false)
    private int day;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shift_type_id", nullable = false)
    private ShiftType shiftType;
}
