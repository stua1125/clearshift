import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/models/shift_type.dart';

class ShiftTypeFormSheet extends StatefulWidget {
  const ShiftTypeFormSheet({
    super.key,
    this.initial,
    required this.onSave,
  });

  final ShiftType? initial;
  final ValueChanged<ShiftType> onSave;

  @override
  State<ShiftTypeFormSheet> createState() => _ShiftTypeFormSheetState();
}

class _ShiftTypeFormSheetState extends State<ShiftTypeFormSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _abbrController;
  late Color _selectedColor;
  late Color _selectedBgColor;
  late ShiftCategory _category;

  static const _presetColors = [
    (color: AppColors.shiftMorning, bg: AppColors.shiftMorningBg, label: '파랑'),
    (color: AppColors.shiftNight, bg: AppColors.shiftNightBg, label: '보라'),
    (color: AppColors.shiftAfternoon, bg: AppColors.shiftAfternoonBg, label: '주황'),
    (color: AppColors.shiftOff, bg: AppColors.shiftOffBg, label: '회색'),
    (color: AppColors.shiftEvening, bg: AppColors.shiftEveningBg, label: '초록'),
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initial?.name ?? '');
    _abbrController =
        TextEditingController(text: widget.initial?.abbreviation ?? '');
    _selectedColor = widget.initial?.color ?? _presetColors[0].color;
    _selectedBgColor = widget.initial?.bgColor ?? _presetColors[0].bg;
    _category = widget.initial?.category ?? ShiftCategory.work;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _abbrController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xxl,
        right: AppSpacing.xxl,
        top: AppSpacing.lg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.initial != null ? '근무타입 편집' : '새 근무타입',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: '이름'),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _abbrController,
            decoration: const InputDecoration(labelText: '약어 (1~3자)'),
            maxLength: 3,
          ),
          const SizedBox(height: AppSpacing.md),
          Text('색상', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: 8,
            children: _presetColors.map((preset) {
              final isSelected = _selectedColor == preset.color;
              return GestureDetector(
                onTap: () => setState(() {
                  _selectedColor = preset.color;
                  _selectedBgColor = preset.bg;
                }),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: preset.color,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: AppColors.textPrimary, width: 2)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<ShiftCategory>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: '카테고리'),
            items: const [
              DropdownMenuItem(
                value: ShiftCategory.work,
                child: Text('근무조'),
              ),
              DropdownMenuItem(
                value: ShiftCategory.leave,
                child: Text('휴가'),
              ),
              DropdownMenuItem(
                value: ShiftCategory.other,
                child: Text('기타'),
              ),
            ],
            onChanged: (v) {
              if (v != null) setState(() => _category = v);
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
              ),
              child: const Text('저장'),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    final name = _nameController.text.trim();
    final abbr = _abbrController.text.trim();
    if (name.isEmpty || abbr.isEmpty) return;

    widget.onSave(ShiftType(
      id: widget.initial?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      abbreviation: abbr,
      color: _selectedColor,
      bgColor: _selectedBgColor,
      category: _category,
      sortOrder: widget.initial?.sortOrder ?? 0,
    ));
  }
}
