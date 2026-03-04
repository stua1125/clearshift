import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/models/calendar_event.dart';

class EventFormSheet extends StatefulWidget {
  const EventFormSheet({
    super.key,
    this.initial,
    required this.onSave,
  });

  final CalendarEvent? initial;
  final ValueChanged<CalendarEvent> onSave;

  @override
  State<EventFormSheet> createState() => _EventFormSheetState();
}

class _EventFormSheetState extends State<EventFormSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;
  late Color _selectedColor;
  late DateTime _startDate;
  late DateTime _endDate;

  static const _presetColors = [
    (color: AppColors.primary, label: '파랑'),
    (color: AppColors.shiftNight, label: '보라'),
    (color: AppColors.success, label: '초록'),
    (color: AppColors.warning, label: '주황'),
    (color: AppColors.error, label: '빨강'),
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initial?.title ?? '');
    _memoController = TextEditingController(text: widget.initial?.memo ?? '');
    _selectedColor = widget.initial?.color ?? _presetColors[0].color;
    _startDate = widget.initial?.startDate ?? DateTime.now();
    _endDate = widget.initial?.endDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
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
            widget.initial != null ? '이벤트 편집' : '새 이벤트',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: '제목'),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _DateButton(
                  label: '시작',
                  date: _startDate,
                  onTap: () => _pickDate(isStart: true),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _DateButton(
                  label: '종료',
                  date: _endDate,
                  onTap: () => _pickDate(isStart: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text('색상', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: 8,
            children: _presetColors.map((preset) {
              final isSelected = _selectedColor == preset.color;
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = preset.color),
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
          TextField(
            controller: _memoController,
            decoration: const InputDecoration(labelText: '메모'),
            maxLines: 2,
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

  Future<void> _pickDate({required bool isStart}) async {
    final date = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        if (isStart) {
          _startDate = date;
          if (_endDate.isBefore(_startDate)) _endDate = _startDate;
        } else {
          _endDate = date;
        }
      });
    }
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    widget.onSave(CalendarEvent(
      id: widget.initial?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      teamId: widget.initial?.teamId ?? '',
      title: title,
      startDate: _startDate,
      endDate: _endDate,
      color: _selectedColor,
      memo: _memoController.text.trim().isEmpty
          ? null
          : _memoController.text.trim(),
    ));
  }
}

class _DateButton extends StatelessWidget {
  const _DateButton({
    required this.label,
    required this.date,
    required this.onTap,
  });

  final String label;
  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppSpacing.inputBorderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textTertiary,
              ),
            ),
            Text(
              '${date.year}/${date.month}/${date.day}',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
