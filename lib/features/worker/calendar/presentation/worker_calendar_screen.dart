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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              _Header(),
              const SizedBox(height: AppSpacing.lg),
              _MonthNavigator(
                year: state.year,
                month: state.month,
                onPrevious: () => notifier.navigateMonth(-1),
                onNext: () => notifier.navigateMonth(1),
              ),
              const SizedBox(height: AppSpacing.md),
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
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text(
              'CS',
              style: TextStyle(
                color: AppColors.onPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          'ClearShift',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
          ),
          child: const Text(
            '근무자',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left),
          iconSize: 28,
        ),
        Text(
          '$year년 $month월',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right),
          iconSize: 28,
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
