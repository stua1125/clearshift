import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/calendar_grid.dart';
import '../../../../core/widgets/paint_toolbar.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../../../../core/widgets/submit_bar.dart';
import 'providers/calendar_provider.dart';

class WorkerCalendarScreen extends ConsumerWidget {
  const WorkerCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workerCalendarProvider);
    final notifier = ref.read(workerCalendarProvider.notifier);
    final daysInMonth = DateTime(state.year, state.month + 1, 0).day;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
            child: _MonthNavigator(
              year: state.year,
              month: state.month,
              onPrevious: () => notifier.navigateMonth(-1),
              onNext: () => notifier.navigateMonth(1),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  CalendarGrid(
                    year: state.year,
                    month: state.month,
                    assignments: state.assignments,
                    isPaintMode: state.paintMode,
                    selectedShiftType: state.selectedShiftType,
                    onDayTap: notifier.tapDay,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PaintToolbar(
                    shiftTypes: state.shiftTypes,
                    selectedType: state.selectedShiftType,
                    isPaintMode: state.paintMode,
                    onSelectType: notifier.selectShiftType,
                    onTogglePaint: notifier.togglePaintMode,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SubmitBar(
                    filledCount: state.assignments.length,
                    totalDays: daysInMonth,
                    status: state.submissionStatus,
                    onSubmit: notifier.submitSchedule,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _Legend(shiftTypes: state.shiftTypes),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthNavigator extends StatelessWidget {
  const _MonthNavigator({
    required this.year,
    required this.month,
    required this.onPrevious,
    required this.onNext,
  });

  final int year;
  final int month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$year년 $month월',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left, size: 24),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            shape: const CircleBorder(),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right, size: 24),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceVariant,
            shape: const CircleBorder(),
          ),
        ),
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.shiftTypes});

  final List<dynamic> shiftTypes;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: shiftTypes.map((type) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShiftBadge(shiftType: type, size: ShiftBadgeSize.sm),
            const SizedBox(width: 4),
            Text(
              type.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}
