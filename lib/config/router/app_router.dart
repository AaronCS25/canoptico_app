import 'package:go_router/go_router.dart';

import 'package:canoptico_app/features/stats/stats.dart';
import 'package:canoptico_app/features/shared/shared.dart';
import 'package:canoptico_app/features/history/history.dart';
import 'package:canoptico_app/features/schedule/schedule.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          RootScreen(navigationShell: navigationShell),
      branches: [
        // -- BOTTOM NAVIGATION BAR BRANCHES --
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/schedule',
              builder: (context, state) => const ScheduleView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (context, state) => const HistoryView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stats',
              builder: (context, state) => const StatsView(),
            ),
          ],
        ),
      ],
    ),
  ],
);
