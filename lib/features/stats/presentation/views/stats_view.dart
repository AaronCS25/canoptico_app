import 'package:flutter/material.dart';
import 'package:canoptico_app/features/stats/stats.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _StatsViewBody());
  }
}

class _StatsViewBody extends StatelessWidget {
  const _StatsViewBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.stacked_bar_chart_outlined,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text("Analytics", style: theme.textTheme.headlineMedium),
            ],
          ),

          const SizedBox(height: 16.0),

          // this week's summary
          const WeeklyConsumptionWidget(),

          const SizedBox(height: 16),

          // environment's summary
          const EnvironmentWidget(),

          const SizedBox(height: 16.0),

          // food level
          const FoodLevelWidget(),
        ],
      ),
    );
  }
}
