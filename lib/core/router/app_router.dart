import 'package:go_router/go_router.dart';

import '../../features/worker/calendar/presentation/worker_calendar_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/worker/calendar',
  routes: [
    GoRoute(
      path: '/worker/calendar',
      builder: (context, state) => const WorkerCalendarScreen(),
    ),
  ],
);
