import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../shared/models/shift_type.dart';
import '../providers/shift_types_provider.dart';
import 'widgets/shift_type_form_sheet.dart';

class ShiftTypesScreen extends ConsumerStatefulWidget {
  const ShiftTypesScreen({super.key});

  @override
  ConsumerState<ShiftTypesScreen> createState() => _ShiftTypesScreenState();
}

class _ShiftTypesScreenState extends ConsumerState<ShiftTypesScreen> {
  String _filterStatus = 'all';

  List<ShiftType> _filterTypes(List<ShiftType> types) {
    switch (_filterStatus) {
      case 'active':
        return types.where((t) => t.isActive).toList();
      case 'inactive':
        return types.where((t) => !t.isActive).toList();
      default:
        return types;
    }
  }

  @override
  Widget build(BuildContext context) {
    final shiftTypes = ref.watch(shiftTypesProvider);
    final notifier = ref.read(shiftTypesProvider.notifier);
    final filteredTypes = _filterTypes(shiftTypes);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('근무타입 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showOptionsSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _FilterTabs(
            selected: _filterStatus,
            onChanged: (status) => setState(() => _filterStatus = status),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: filteredTypes.length,
              onReorder: notifier.reorder,
              itemBuilder: (context, index) {
                final type = filteredTypes[index];
                return _ShiftTypeItem(
                  key: ValueKey(type.id),
                  shiftType: type,
                  onEdit: () => _showEditSheet(context, notifier, type),
                  onDeactivate: () => _confirmDeactivate(context, notifier, type),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, notifier),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSheet(BuildContext context, ShiftTypesNotifier notifier) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ShiftTypeFormSheet(
        onSave: (type) {
          notifier.add(type);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditSheet(
    BuildContext context,
    ShiftTypesNotifier notifier,
    ShiftType type,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ShiftTypeFormSheet(
        initial: type,
        onSave: (updated) {
          notifier.update(updated);
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _confirmDeactivate(
    BuildContext context,
    ShiftTypesNotifier notifier,
    ShiftType type,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: '근무타입 비활성화',
      message: '이 근무타입을 비활성화하시겠습니까?',
      confirmText: '비활성화',
      isDestructive: true,
    );
    if (confirmed) {
      notifier.deactivate(type.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('근무타입이 비활성화되었습니다')),
        );
      }
    }
  }

  void _showOptionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.sort),
              title: const Text('정렬 순서 변경'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.visibility_off_outlined),
              title: const Text('비활성 타입 숨기기'),
              onTap: () {
                Navigator.pop(context);
                setState(() => _filterStatus = 'active');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterTabs extends StatelessWidget {
  const _FilterTabs({
    required this.selected,
    required this.onChanged,
  });

  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          _buildChip('전체', 'all'),
          const SizedBox(width: AppSpacing.sm),
          _buildChip('활성', 'active'),
          const SizedBox(width: AppSpacing.sm),
          _buildChip('비활성', 'inactive'),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppColors.onPrimary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _ShiftTypeItem extends StatelessWidget {
  const _ShiftTypeItem({
    super.key,
    required this.shiftType,
    required this.onEdit,
    required this.onDeactivate,
  });

  final ShiftType shiftType;
  final VoidCallback onEdit;
  final VoidCallback onDeactivate;

  @override
  Widget build(BuildContext context) {
    final timeRange = (shiftType.startTime != null && shiftType.endTime != null)
        ? ' | ${shiftType.startTime} - ${shiftType.endTime}'
        : '';

    return GestureDetector(
      onLongPress: () => _showContextMenu(context),
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.drag_handle,
                color: AppColors.textTertiary,
                size: 24,
              ),
              const SizedBox(width: AppSpacing.sm),
              Opacity(
                opacity: shiftType.isActive ? 1.0 : 0.4,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: shiftType.bgColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    shiftType.abbreviation,
                    style: TextStyle(
                      color: shiftType.color,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${shiftType.name} (${shiftType.abbreviation})',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: shiftType.isActive
                                ? AppColors.textPrimary
                                : AppColors.textTertiary,
                          ),
                        ),
                        if (!shiftType.isActive) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              '비활성',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textTertiary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '약어: ${shiftType.abbreviation}$timeRange',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('편집'),
              onTap: () {
                Navigator.pop(context);
                onEdit();
              },
            ),
            if (shiftType.isActive)
              ListTile(
                leading: Icon(Icons.visibility_off_outlined,
                    color: AppColors.error),
                title: Text(
                  '비활성화',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onDeactivate();
                },
              ),
          ],
        ),
      ),
    );
  }
}
