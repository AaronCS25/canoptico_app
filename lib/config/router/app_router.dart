import 'package:canoptico_app/config/config.dart';
import 'package:go_router/go_router.dart';
import 'package:canoptico_app/features/auth/auth.dart';
import 'package:canoptico_app/features/stats/stats.dart';
import 'package:canoptico_app/features/shared/shared.dart';
import 'package:canoptico_app/features/history/history.dart';
import 'package:canoptico_app/features/schedule/schedule.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

GoRouter createRouter(AuthBloc authBloc) {
  final goRouterNotifier = GoRouterNotifier(authBloc);
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == "/splash" && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/signup') {
          return null;
        }
        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/signup' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
    routes: [
      // ** AUTH MODULE ROUTES **
      GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: "/splash",
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),

      // ** SHARED MODULE ROUTES **
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
}

/*
final router = GoRouter(
  initialLocation: '/login',
  routes: [
    // ** AUTH MODULE ROUTES **
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/signup", builder: (context, state) => const SignupScreen()),

    // ** SHARED MODULE ROUTES **
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
*/
