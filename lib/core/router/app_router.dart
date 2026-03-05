import 'package:go_router/go_router.dart';

import '../../features/manager/events/presentation/events_screen.dart';
import '../../features/manager/shift_types/presentation/shift_types_screen.dart';
import '../../features/manager/vacation_settings/presentation/vacation_settings_screen.dart';
import '../../features/shared_calendar/presentation/shared_calendar_screen.dart';
import '../../features/worker/calendar/presentation/worker_calendar_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/shared/calendar',
  routes: [
    GoRoute(
      path: '/shared/calendar',
      builder: (context, state) => const SharedCalendarScreen(),
    ),
    GoRoute(
      path: '/worker/calendar',
      builder: (context, state) => const WorkerCalendarScreen(),
    ),
    GoRoute(
      path: '/manager/shift-types',
      builder: (context, state) => const ShiftTypesScreen(),
    ),
    GoRoute(
      path: '/manager/vacation-settings',
      builder: (context, state) => const VacationSettingsScreen(),
    ),
    GoRoute(
      path: '/manager/events',
      builder: (context, state) => const EventsScreen(),
    ),
  ],
);
