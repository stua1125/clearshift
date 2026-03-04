import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/vacation_settings_provider.dart';

class VacationSettingsScreen extends ConsumerWidget {
  const VacationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vacationSettingsProvider);
    final notifier = ref.read(vacationSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('휴가 MAX 관리')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DefaultMaxCard(
              defaultMax: state.defaultMax,
              onIncrement: notifier.incrementDefault,
              onDecrement: notifier.decrementDefault,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('일자별 Override', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.md),
            _OverrideForm(onAdd: notifier.addOverride),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.overrides.entries.map((entry) {
                return Chip(
                  backgroundColor: AppColors.shiftVacationBg,
                  side: BorderSide.none,
                  label: Text(
                    '${entry.key}일: ${entry.value}명',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.shiftVacation,
                    ),
                  ),
                  deleteIcon: Icon(Icons.close, size: 16, color: AppColors.shiftVacation),
                  onDeleted: () => notifier.removeOverride(entry.key),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultMaxCard extends StatelessWidget {
  const _DefaultMaxCard({
    required this.defaultMax,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int defaultMax;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('일일 기본 휴가 MAX', style: Theme.of(context).textTheme.titleSmall),
            Row(
              children: [
                IconButton(
                  onPressed: onDecrement,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.primary,
                ),
                Text(
                  '$defaultMax',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                IconButton(
                  onPressed: onIncrement,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OverrideForm extends StatefulWidget {
  const _OverrideForm({required this.onAdd});

  final void Function(int day, int max) onAdd;

  @override
  State<_OverrideForm> createState() => _OverrideFormState();
}

class _OverrideFormState extends State<_OverrideForm> {
  final _dayController = TextEditingController();
  final _maxController = TextEditingController();

  @override
  void dispose() {
    _dayController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _dayController,
            decoration: const InputDecoration(labelText: '날짜 (일)'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: TextField(
            controller: _maxController,
            decoration: const InputDecoration(labelText: 'MAX'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        ElevatedButton(
          onPressed: () {
            final day = int.tryParse(_dayController.text);
            final max = int.tryParse(_maxController.text);
            if (day != null && max != null && day >= 1 && day <= 31) {
              widget.onAdd(day, max);
              _dayController.clear();
              _maxController.clear();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.onPrimary,
          ),
          child: const Text('적용'),
        ),
      ],
    );
  }
}
