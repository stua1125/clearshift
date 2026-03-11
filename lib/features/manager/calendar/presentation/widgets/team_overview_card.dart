import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/widgets/submit_bar.dart';
import '../../providers/manager_calendar_provider.dart';

class TeamOverviewCard extends StatelessWidget {
  const TeamOverviewCard({
    super.key,
    required this.members,
    this.onMemberTap,
  });

  final List<TeamMember> members;
  final void Function(TeamMember member)? onMemberTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('팀원 현황', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: AppSpacing.md),
            ...members.map((m) => _MemberRow(
                  member: m,
                  onTap: onMemberTap != null ? () => onMemberTap!(m) : null,
                )),
          ],
        ),
      ),
    );
  }
}

class _MemberRow extends StatelessWidget {
  const _MemberRow({required this.member, this.onTap});

  final TeamMember member;
  final VoidCallback? onTap;

  Color get _avatarColor {
    final colors = [
      AppColors.shiftMorning,
      AppColors.shiftAfternoon,
      AppColors.shiftNight,
      AppColors.shiftOff,
      AppColors.shiftEvening,
    ];
    return colors[member.name.hashCode.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: _avatarColor,
              child: Text(
                member.name.substring(0, 1),
                style: const TextStyle(
                  color: AppColors.textOnColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                member.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            _StatusBadge(
              status: member.status,
              filledPercent: member.filledPercent,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.status,
    required this.filledPercent,
  });

  final SubmissionStatus status;
  final int filledPercent;

  @override
  Widget build(BuildContext context) {
    final (text, bgColor, textColor) = switch (status) {
      SubmissionStatus.submitted => (
          '제출 완료',
          AppColors.success.withValues(alpha: 0.1),
          AppColors.success,
        ),
      SubmissionStatus.draft when filledPercent > 0 => (
          '작성중 $filledPercent%',
          AppColors.warning.withValues(alpha: 0.1),
          AppColors.warning,
        ),
      _ => (
          '미시작',
          AppColors.surfaceVariant,
          AppColors.textTertiary,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.buttonBorderRadius),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}
