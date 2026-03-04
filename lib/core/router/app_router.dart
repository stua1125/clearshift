import 'package:go_router/go_router.dart';

import '../../features/manager/calendar/presentation/manager_calendar_screen.dart';
import '../../features/manager/events/presentation/events_screen.dart';
import '../../features/manager/team/presentation/member_schedule_screen.dart';
import '../../features/manager/shift_types/presentation/shift_types_screen.dart';
import '../../features/manager/vacation_settings/presentation/vacation_settings_screen.dart';
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
    GoRoute(
      path: '/manager/vacation-settings',
      builder: (context, state) => const VacationSettingsScreen(),
    ),
    GoRoute(
      path: '/manager/events',
      builder: (context, state) => const EventsScreen(),
    ),
    GoRoute(
      path: '/manager/team/:memberId/schedule',
      builder: (context, state) {
        final memberId = state.pathParameters['memberId']!;
        final memberName =
            state.uri.queryParameters['name'] ?? '팀원';
        return MemberScheduleScreen(
          memberId: memberId,
          memberName: memberName,
        );
      },
    ),
  ],
);
