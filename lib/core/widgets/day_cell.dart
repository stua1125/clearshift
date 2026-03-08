import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/models/calendar_event.dart';
import '../../shared/models/shift_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import 'shift_badge.dart';

class DayCell extends StatefulWidget {
  const DayCell({
    super.key,
    required this.day,
    this.shift,
    this.event,
    this.isToday = false,
    this.isSunday = false,
    this.isSaturday = false,
    this.isPaintMode = false,
    this.vacationInfo,
    this.onTap,
  });

  final int day;
  final ShiftType? shift;
  final CalendarEvent? event;
  final bool isToday;
  final bool isSunday;
  final bool isSaturday;
  final bool isPaintMode;
  final ({int current, int max})? vacationInfo;
  final VoidCallback? onTap;

  @override
  State<DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<DayCell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.isPaintMode || widget.onTap == null) return;
    HapticFeedback.lightImpact();
    _scaleController.forward().then((_) => _scaleController.reverse());
    widget.onTap!();
  }

  Color get _dayColor {
    if (widget.isSunday) return AppColors.calendarSunday;
    if (widget.isSaturday) return AppColors.calendarSaturday;
    return AppColors.textPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          height: AppSpacing.cellHeightMobile,
          padding: const EdgeInsets.all(AppSpacing.cellPadding),
          decoration: BoxDecoration(
            color: widget.shift != null
                ? widget.shift!.bgColor.withValues(alpha: 0.3)
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(color: AppColors.borderLight, width: 0.5),
              right: BorderSide(color: AppColors.borderLight, width: 0.5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Day number + today indicator
              Row(
                children: [
                  if (widget.isToday)
                    Container(
                      width: 22,
                      height: 22,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.day}',
                        style: AppTypography.calendarDay.copyWith(
                          color: AppColors.onPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  else
                    Text(
                      '${widget.day}',
                      style: AppTypography.calendarDay.copyWith(color: _dayColor),
                    ),
                  const Spacer(),
                  if (widget.shift != null)
                    ShiftBadge(
                      shiftType: widget.shift!,
                      size: ShiftBadgeSize.sm,
                    ),
                ],
              ),
              const Spacer(),
              // Event chip (TimeTree-style colored text)
              if (widget.event != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  decoration: BoxDecoration(
                    color: widget.event!.color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    widget.event!.title,
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.textOnColor,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (widget.vacationInfo != null && widget.event == null)
                Text(
                  '${widget.vacationInfo!.current}/${widget.vacationInfo!.max}',
                  style: TextStyle(
                    fontSize: 9,
                    color: widget.vacationInfo!.current >=
                            widget.vacationInfo!.max
                        ? AppColors.error
                        : AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
