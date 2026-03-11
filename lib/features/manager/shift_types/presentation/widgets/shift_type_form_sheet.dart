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
  final _formKey = GlobalKey<FormState>();
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
        top: AppSpacing.md,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.xxl,
      ),
      child: Form(
        key: _formKey,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.close, size: 24),
                onPressed: () => Navigator.pop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.initial != null ? '근무타입 편집' : '새 근무타입',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: '근무 명칭',
              hintText: '예: 오전근무',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '근무 명칭을 입력해주세요';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: _abbrController,
            decoration: const InputDecoration(
              labelText: '약칭',
              hintText: '예: 오전',
            ),
            maxLength: 3,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '약칭을 입력해주세요';
              }
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<ShiftCategory>(
            initialValue: _category,
            decoration: const InputDecoration(labelText: '카테고리'),
            items: const [
              DropdownMenuItem(
                value: ShiftCategory.work,
                child: Text('일반 근무'),
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
          const SizedBox(height: AppSpacing.lg),
          Text('색상', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _presetColors.map((preset) {
              final isSelected = _selectedColor == preset.color;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => setState(() {
                    _selectedColor = preset.color;
                    _selectedBgColor = preset.bg;
                  }),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: preset.color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(color: AppColors.textPrimary, width: 3)
                          : null,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '저장',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('필수 항목을 입력해주세요')),
      );
      return;
    }
    final name = _nameController.text.trim();
    final abbr = _abbrController.text.trim();

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
