import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/shift_types.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/calendar_grid.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../../../../core/widgets/submit_bar.dart';
import '../../../../shared/models/shift_type.dart';

class MemberScheduleScreen extends ConsumerWidget {
  const MemberScheduleScreen({
    super.key,
    required this.memberId,
    required this.memberName,
  });

  final String memberId;
  final String memberName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    // Mock data for demonstration
    final mockAssignments = <int, ShiftType>{
      for (var i = 1; i <= 20; i++) i: defaultShiftTypes[i % 5],
    };
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return Scaffold(
      appBar: AppBar(title: Text('$memberName 스케줄')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MemberInfo(name: memberName),
            const SizedBox(height: AppSpacing.lg),
            CalendarGrid(
              year: now.year,
              month: now.month,
              assignments: mockAssignments,
              isPaintMode: false,
              onDayTap: (_) {},
            ),
            const SizedBox(height: AppSpacing.lg),
            _StatsSummary(assignments: mockAssignments),
            const SizedBox(height: AppSpacing.lg),
            SubmitBar(
              filledCount: mockAssignments.length,
              totalDays: daysInMonth,
              status: SubmissionStatus.submitted,
            ),
            const SizedBox(height: AppSpacing.lg),
            _ActionButtons(
              onApprove: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('승인되었습니다')),
                );
              },
              onReject: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('반려되었습니다')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberInfo extends StatelessWidget {
  const _MemberInfo({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primary,
          child: Text(
            name.substring(0, 1),
            style: const TextStyle(
              color: AppColors.textOnColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: Theme.of(context).textTheme.titleMedium),
            const Text(
              '근무자',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatsSummary extends StatelessWidget {
  const _StatsSummary({required this.assignments});

  final Map<int, ShiftType> assignments;

  @override
  Widget build(BuildContext context) {
    final counts = <String, int>{};
    for (final type in assignments.values) {
      counts[type.name] = (counts[type.name] ?? 0) + 1;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('근무 통계', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.sm,
              children: counts.entries.map((entry) {
                final shiftType = assignments.values
                    .firstWhere((t) => t.name == entry.key);
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShiftBadge(
                      shiftType: shiftType,
                      size: ShiftBadgeSize.sm,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.key}: ${entry.value}일',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.onApprove,
    required this.onReject,
  });

  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onReject,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            ),
            child: const Text('반려'),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: ElevatedButton(
            onPressed: onApprove,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            ),
            child: const Text('승인'),
          ),
        ),
      ],
    );
  }
}
