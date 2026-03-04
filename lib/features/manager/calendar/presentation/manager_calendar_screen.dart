import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/calendar_grid.dart';
import '../providers/manager_calendar_provider.dart';
import 'widgets/day_detail_sheet.dart';
import 'widgets/team_overview_card.dart';

class ManagerCalendarScreen extends ConsumerWidget {
  const ManagerCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(managerCalendarProvider);
    final notifier = ref.read(managerCalendarProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              _ManagerHeader(),
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
                assignments: const {},
                events: state.events,
                isPaintMode: false,
                onDayTap: (day) => _showDayDetail(context, state, day),
                vacationInfoBuilder: (day) {
                  final current = state.vacationCounts[day] ?? 0;
                  final maxVal = state.vacationOverrides[day] ??
                      state.defaultVacationMax;
                  return (current: current, max: maxVal);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              TeamOverviewCard(members: state.teamMembers),
            ],
          ),
        ),
      ),
    );
  }

  void _showDayDetail(
    BuildContext context,
    ManagerCalendarState state,
    int day,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => DayDetailSheet(
        day: day,
        month: state.month,
        year: state.year,
        memberAssignments: state.getMemberAssignments(day),
      ),
    );
  }
}

class _ManagerHeader extends StatelessWidget {
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
        Text('ClearShift', style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.shiftNightBg,
            borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
          ),
          child: const Text(
            '매니저',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.shiftNight,
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
