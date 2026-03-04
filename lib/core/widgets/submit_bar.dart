import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

enum SubmissionStatus { draft, submitted, approved, rejected }

class SubmitBar extends StatelessWidget {
  const SubmitBar({
    super.key,
    required this.filledCount,
    required this.totalDays,
    this.status = SubmissionStatus.draft,
    this.onSubmit,
  });

  final int filledCount;
  final int totalDays;
  final SubmissionStatus status;
  final VoidCallback? onSubmit;

  double get _progress => totalDays > 0 ? filledCount / totalDays : 0;
  int get _percent => (_progress * 100).round();
  bool get _canSubmit =>
      filledCount >= totalDays && status == SubmissionStatus.draft;

  Color get _progressColor {
    if (_progress >= 1.0) return AppColors.success;
    if (_progress >= 0.5) return AppColors.primary;
    return AppColors.warning;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '작성 현황: $filledCount/$totalDays일 $_percent%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                _buildActionWidget(context),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: _progress,
                minHeight: 6,
                backgroundColor: AppColors.surfaceVariant,
                valueColor: AlwaysStoppedAnimation<Color>(_progressColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionWidget(BuildContext context) {
    if (status == SubmissionStatus.submitted ||
        status == SubmissionStatus.approved) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, size: 14, color: AppColors.success),
            SizedBox(width: 4),
            Text(
              '제출 완료',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      );
    }

    if (status == SubmissionStatus.rejected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
        ),
        child: const Text(
          '반려됨',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.error,
          ),
        ),
      );
    }

    return ElevatedButton(
      onPressed: _canSubmit ? onSubmit : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.surfaceVariant,
        disabledForegroundColor: AppColors.textTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: const Text('제출하기'),
    );
  }
}
