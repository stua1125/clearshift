import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import 'providers/shared_calendar_provider.dart';
import 'widgets/shared_day_detail_sheet.dart';
import 'widgets/shared_monthly_view.dart';
import 'widgets/shared_weekly_view.dart';

class SharedCalendarScreen extends ConsumerWidget {
  const SharedCalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sharedCalendarProvider);
    final notifier = ref.read(sharedCalendarProvider.notifier);

    return SafeArea(
      child: Column(
        children: [
          // Fixed header area
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
            child: Column(
              children: [
                _MonthNavigator(
                  year: state.year,
                  month: state.month,
                  onPrevious: () => notifier.navigateMonth(-1),
                  onNext: () => notifier.navigateMonth(1),
                ),
                const SizedBox(height: AppSpacing.sm),
                _ViewModeToggle(
                  viewMode: state.viewMode,
                  onChanged: notifier.switchView,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
          // Scrollable calendar
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: state.viewMode == CalendarViewMode.monthly
                  ? SharedMonthlyView(
                      year: state.year,
                      month: state.month,
                      daySummaries: state.daySummaries,
                      events: state.events,
                      onDayTap: (day) => _showDayDetail(context, state, day),
                    )
                  : SharedWeeklyView(
                      year: state.year,
                      month: state.month,
                      weekStartDay: state.selectedWeekStartDay,
                      members: state.weekMembers,
                      events: state.events,
                      onWeekChange: notifier.selectWeek,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDayDetail(
    BuildContext context,
    SharedCalendarState state,
    int day,
  ) {
    final date = DateTime(state.year, state.month, day);
    final dayEvents = state.events
        .where((e) => !date.isBefore(e.startDate) && !date.isAfter(e.endDate))
        .toList();

    showModalBottomSheet(
      context: context,
      builder: (context) => SharedDayDetailSheet(
        day: day,
        month: state.month,
        year: state.year,
        summary: state.daySummaries[day],
        events: dayEvents,
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

class _ViewModeToggle extends StatelessWidget {
  const _ViewModeToggle({
    required this.viewMode,
    required this.onChanged,
  });

  final CalendarViewMode viewMode;
  final ValueChanged<CalendarViewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
      ),
      padding: const EdgeInsets.all(3),
      child: Row(
        children: [
          _buildTab('월간', CalendarViewMode.monthly),
          _buildTab('주간', CalendarViewMode.weekly),
        ],
      ),
    );
  }

  Widget _buildTab(String label, CalendarViewMode mode) {
    final isSelected = viewMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(mode),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius:
                BorderRadius.circular(AppSpacing.buttonBorderRadius - 1),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 4,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
