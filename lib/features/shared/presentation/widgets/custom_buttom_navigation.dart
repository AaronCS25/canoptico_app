import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavigation({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: navigationShell.goBranch,
      // Theme
      indicatorColor: Theme.of(context).colorScheme.primary,
      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.home_max_outlined,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          selectedIcon: Icon(
            Icons.home_max_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.calendar_month_outlined,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          selectedIcon: Icon(
            Icons.calendar_month_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: 'Schedule',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.history,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          selectedIcon: Icon(
            Icons.history,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: 'History',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.stacked_bar_chart_outlined,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          selectedIcon: Icon(
            Icons.stacked_bar_chart_outlined,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: 'Stats',
        ),
      ],
    );
  }
}
