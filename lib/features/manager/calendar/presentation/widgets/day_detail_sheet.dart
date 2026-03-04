import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/shift_badge.dart';
import '../../../../../shared/models/shift_type.dart';

class DayDetailSheet extends StatelessWidget {
  const DayDetailSheet({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.memberAssignments,
  });

  final int day;
  final int month;
  final int year;
  final Map<String, ShiftType?> memberAssignments;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$year년 $month월 $day일',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          ...memberAssignments.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      entry.key.substring(0, 1),
                      style: const TextStyle(
                        color: AppColors.textOnColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(entry.key,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  if (entry.value != null)
                    ShiftBadge(shiftType: entry.value!, size: ShiftBadgeSize.md)
                  else
                    Text(
                      '미배정',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                    ),
                ],
              ),
            );
          }),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
