import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/models/calendar_event.dart';
import '../providers/events_provider.dart';
import 'widgets/event_form_sheet.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final notifier = ref.read(eventsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('이벤트 관리')),
      body: events.isEmpty
          ? const Center(
              child: Text(
                '등록된 이벤트가 없습니다',
                style: TextStyle(color: AppColors.textTertiary),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return _EventCard(
                  event: event,
                  onTap: () => _showEditSheet(context, notifier, event),
                  onDelete: () => notifier.remove(event.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSheet(context, notifier),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSheet(BuildContext context, EventsNotifier notifier) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EventFormSheet(
        onSave: (event) {
          notifier.add(event);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditSheet(
    BuildContext context,
    EventsNotifier notifier,
    CalendarEvent event,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => EventFormSheet(
        initial: event,
        onSave: (updated) {
          notifier.update(updated);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.event,
    required this.onTap,
    required this.onDelete,
  });

  final CalendarEvent event;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: event.color,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(event.title),
        subtitle: Text(
          '${_formatDate(event.startDate)} ~ ${_formatDate(event.endDate)}',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, size: 20, color: AppColors.error),
          onPressed: onDelete,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}';
  }
}
