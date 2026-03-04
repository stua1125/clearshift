import 'package:flutter/material.dart';

import '../../shared/models/shift_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'shift_badge.dart';

class PaintToolbar extends StatelessWidget {
  const PaintToolbar({
    super.key,
    required this.shiftTypes,
    this.selectedType,
    this.isPaintMode = false,
    required this.onSelectType,
    required this.onTogglePaint,
  });

  final List<ShiftType> shiftTypes;
  final ShiftType? selectedType;
  final bool isPaintMode;
  final ValueChanged<ShiftType?> onSelectType;
  final VoidCallback onTogglePaint;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '근무 타입 선택',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                _PaintToggle(
                  isPaintMode: isPaintMode,
                  onToggle: onTogglePaint,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                ...shiftTypes.map((type) => _ShiftTypeButton(
                      shiftType: type,
                      isSelected: selectedType?.id == type.id,
                      isPaintMode: isPaintMode,
                      onTap: () => onSelectType(
                        selectedType?.id == type.id ? null : type,
                      ),
                    )),
                _EraseButton(
                  isSelected: isPaintMode && selectedType == null,
                  onTap: () => onSelectType(null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaintToggle extends StatelessWidget {
  const _PaintToggle({
    required this.isPaintMode,
    required this.onToggle,
  });

  final bool isPaintMode;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isPaintMode ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
        ),
        child: Text(
          isPaintMode ? 'Paint ON' : 'Paint OFF',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isPaintMode ? AppColors.onPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ShiftTypeButton extends StatelessWidget {
  const _ShiftTypeButton({
    required this.shiftType,
    required this.isSelected,
    required this.isPaintMode,
    required this.onTap,
  });

  final ShiftType shiftType;
  final bool isSelected;
  final bool isPaintMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPaintMode ? onTap : null,
      child: AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedOpacity(
          opacity: isPaintMode ? (isSelected ? 1.0 : 0.6) : 0.4,
          duration: const Duration(milliseconds: 150),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: shiftType.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              ShiftBadge(
                shiftType: shiftType,
                size: ShiftBadgeSize.lg,
                selected: isSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EraseButton extends StatelessWidget {
  const _EraseButton({
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.textSecondary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        alignment: Alignment.center,
        child: const Text('지우기', style: TextStyle(fontSize: 12)),
      ),
    );
  }
}
