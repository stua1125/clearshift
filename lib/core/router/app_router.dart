import 'package:go_router/go_router.dart';

import '../../features/manager/calendar/presentation/manager_calendar_screen.dart';
import '../../features/manager/shift_types/presentation/shift_types_screen.dart';
import '../../features/worker/calendar/presentation/worker_calendar_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/worker/calendar',
  routes: [
    GoRoute(
      path: '/worker/calendar',
      builder: (context, state) => const WorkerCalendarScreen(),
    ),
    GoRoute(
      path: '/manager/calendar',
      builder: (context, state) => const ManagerCalendarScreen(),
    ),
    GoRoute(
      path: '/manager/shift-types',
      builder: (context, state) => const ShiftTypesScreen(),
    ),
  ],
);
