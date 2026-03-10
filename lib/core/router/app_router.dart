import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/manager/events/presentation/events_screen.dart';
import '../../features/manager/shift_types/presentation/shift_types_screen.dart';
import '../../features/manager/vacation_settings/presentation/vacation_settings_screen.dart';
import '../../features/settings/presentation/settings_hub_screen.dart';
import '../../features/shared_calendar/presentation/shared_calendar_screen.dart';
import '../../features/worker/calendar/presentation/worker_calendar_screen.dart';
import '../theme/app_colors.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return _ScaffoldWithNav(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const SharedCalendarScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/schedule',
              builder: (context, state) => const WorkerCalendarScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsHubScreen(),
            ),
          ],
        ),
      ],
    ),
    // Settings sub-screens (push with back arrow, no bottom nav)
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings/shift-types',
      builder: (context, state) => const ShiftTypesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings/vacation',
      builder: (context, state) => const VacationSettingsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings/events',
      builder: (context, state) => const EventsScreen(),
    ),
  ],
);

class _ScaffoldWithNav extends StatelessWidget {
  const _ScaffoldWithNav({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.borderLight, width: 0.5),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          height: 64,
          indicatorColor: AppColors.primaryContainer,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: '홈',
            ),
            NavigationDestination(
              icon: Icon(Icons.edit_calendar_outlined),
              selectedIcon: Icon(Icons.edit_calendar),
              label: '근무신청',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}
