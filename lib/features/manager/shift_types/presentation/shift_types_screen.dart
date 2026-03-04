import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/shift_badge.dart';
import '../../../../shared/models/shift_type.dart';
import '../providers/shift_types_provider.dart';
import 'widgets/shift_type_form_sheet.dart';

class ShiftTypesScreen extends ConsumerWidget {
  const ShiftTypesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shiftTypes = ref.watch(shiftTypesProvider);
    final notifier = ref.read(shiftTypesProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('근무타입 관리')),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: shiftTypes.length,
        onReorder: notifier.reorder,
        itemBuilder: (context, index) {
          final type = shiftTypes[index];
          return _ShiftTypeItem(
            key: ValueKey(type.id),
            shiftType: type,
            onEdit: () => _showEditSheet(context, notifier, type),
            onDelete: () => notifier.remove(type.id),
          );
        },
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
}

class _ShiftTypeItem extends StatelessWidget {
  const _ShiftTypeItem({
    super.key,
    required this.shiftType,
    required this.onEdit,
    required this.onDelete,
  });

  final ShiftType shiftType;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: ShiftBadge(shiftType: shiftType, size: ShiftBadgeSize.lg),
        title: Text(shiftType.name),
        subtitle: Text(
          '약어: ${shiftType.abbreviation}',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined, size: 20),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: 20, color: AppColors.error),
              onPressed: onDelete,
            ),
            const Icon(Icons.drag_handle, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
