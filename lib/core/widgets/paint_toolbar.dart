import 'package:flutter/material.dart';

import '../../shared/models/shift_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.bottomSheetRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PaintToggleRow(
            isPaintMode: isPaintMode,
            onToggle: onTogglePaint,
          ),
          if (isPaintMode) ...[
            if (selectedType != null)
              _SelectedIndicator(shiftType: selectedType!),
            const SizedBox(height: AppSpacing.sm),
            _ShiftButtonsRow(
              shiftTypes: shiftTypes,
              selectedType: selectedType,
              onSelectType: onSelectType,
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ],
      ),
    );
  }
}

class _PaintToggleRow extends StatelessWidget {
  const _PaintToggleRow({
    required this.isPaintMode,
    required this.onToggle,
  });

  final bool isPaintMode;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Icon(
            Icons.brush_rounded,
            size: 20,
            color: isPaintMode ? AppColors.primary : AppColors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Paint Mode',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color:
                  isPaintMode ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Switch.adaptive(
            value: isPaintMode,
            onChanged: (_) => onToggle(),
            activeTrackColor: AppColors.primary,
            activeThumbColor: AppColors.onPrimary,
          ),
        ],
      ),
    );
  }
}

class _SelectedIndicator extends StatelessWidget {
  const _SelectedIndicator({required this.shiftType});

  final ShiftType shiftType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: shiftType.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '${shiftType.name} 선택됨',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: shiftType.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShiftButtonsRow extends StatelessWidget {
  const _ShiftButtonsRow({
    required this.shiftTypes,
    this.selectedType,
    required this.onSelectType,
  });

  final List<ShiftType> shiftTypes;
  final ShiftType? selectedType;
  final ValueChanged<ShiftType?> onSelectType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...shiftTypes.map((type) => _CircularShiftButton(
                shiftType: type,
                isSelected: selectedType?.id == type.id,
                onTap: () => onSelectType(
                  selectedType?.id == type.id ? null : type,
                ),
              )),
          _CircularEraseButton(
            isSelected: selectedType == null,
            onTap: () => onSelectType(null),
          ),
        ],
      ),
    );
  }
}

class _CircularShiftButton extends StatelessWidget {
  const _CircularShiftButton({
    required this.shiftType,
    required this.isSelected,
    required this.onTap,
  });

  final ShiftType shiftType;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: shiftType.bgColor,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.primary, width: 2.5)
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              shiftType.abbreviation,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: shiftType.color,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            shiftType.name,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularEraseButton extends StatelessWidget {
  const _CircularEraseButton({
    required this.isSelected,
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.primary, width: 2.5)
                  : null,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.auto_fix_high_rounded,
              size: 22,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          const Text(
            '지우개',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
