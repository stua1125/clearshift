import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/calendar_grid.dart';
import '../../../../core/widgets/paint_toolbar.dart';
import '../../../../core/widgets/submit_bar.dart';
import 'providers/calendar_provider.dart';

class WorkerCalendarScreen extends ConsumerStatefulWidget {
  const WorkerCalendarScreen({super.key});

  @override
  ConsumerState<WorkerCalendarScreen> createState() =>
      _WorkerCalendarScreenState();
}

class _WorkerCalendarScreenState extends ConsumerState<WorkerCalendarScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workerCalendarProvider);
    final notifier = ref.read(workerCalendarProvider.notifier);
    final daysInMonth = DateTime(state.year, state.month + 1, 0).day;
    final isSubmitted = state.submissionStatus == SubmissionStatus.submitted;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: const Text(
          '내 스케줄',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined, size: 22),
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            child: _MonthNavigator(
              year: state.year,
              month: state.month,
              onPrevious: () => notifier.navigateMonth(-1),
              onNext: () => notifier.navigateMonth(1),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: CalendarGrid(
                year: state.year,
                month: state.month,
                assignments: state.assignments,
                isPaintMode: state.paintMode,
                selectedShiftType: state.selectedShiftType,
                onDayTap: notifier.tapDay,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.borderLight),
          if (isSubmitted)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: SubmitBar(
                filledCount: state.assignments.length,
                totalDays: daysInMonth,
                status: state.submissionStatus,
                onSubmit: () => _handleSubmit(notifier, state, daysInMonth),
              ),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.lg),
              child: SubmitBar(
                filledCount: state.assignments.length,
                totalDays: daysInMonth,
                status: state.submissionStatus,
                onSubmit: () => _handleSubmit(notifier, state, daysInMonth),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            PaintToolbar(
              shiftTypes: state.shiftTypes,
              selectedType: state.selectedShiftType,
              isPaintMode: state.paintMode,
              onSelectType: notifier.selectShiftType,
              onTogglePaint: notifier.togglePaintMode,
            ),
          ],
        ],
      ),
    );
  }

  void _handleSubmit(
    WorkerCalendarNotifier notifier,
    dynamic state,
    int daysInMonth,
  ) {
    final previousStatus = state.submissionStatus;
    notifier.submitSchedule();
    final newStatus = ref.read(workerCalendarProvider).submissionStatus;
    if (previousStatus != SubmissionStatus.submitted &&
        newStatus == SubmissionStatus.submitted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('스케줄이 제출되었습니다')),
      );
    }
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
          icon: const Icon(Icons.chevron_left, size: 24),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(36, 36),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          '$year년 $month월',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        IconButton(
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right, size: 24),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(36, 36),
          ),
        ),
      ],
    );
  }
}
