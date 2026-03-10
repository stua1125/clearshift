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
            Text(
              '기본 휴가 제한 설정',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            _DefaultMaxCard(
              defaultMax: state.defaultMax,
              onIncrement: notifier.incrementDefault,
              onDecrement: notifier.decrementDefault,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              '특정 일자 예외 설정',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            _OverrideForm(onAdd: notifier.addOverride),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.overrides.entries.map((entry) {
                return Chip(
                  backgroundColor: AppColors.primaryContainer,
                  side: BorderSide.none,
                  avatar: Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  label: Text(
                    '${entry.key}일: ${entry.value}명',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  deleteIcon: Icon(Icons.close, size: 16, color: AppColors.primary),
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
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '기본 MAX 인원',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '모든 날짜에 적용되는 기본값',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  size: 28,
                  color: AppColors.textTertiary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CounterButton(
                  icon: Icons.remove,
                  onPressed: onDecrement,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  child: Text(
                    '$defaultMax',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                  ),
                ),
                _CounterButton(
                  icon: Icons.add,
                  onPressed: onIncrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  const _CounterButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.onPrimary, size: 24),
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
            decoration: const InputDecoration(labelText: 'MAX 인원'),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          height: 48,
          child: ElevatedButton(
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('추가'),
          ),
        ),
      ],
    );
  }
}
