import 'package:flutter/material.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _DashboardViewBody();
  }
}

class _DashboardViewBody extends StatelessWidget {
  const _DashboardViewBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          FeederStatusWidget(
            status: FeederStatus.ready,
            lastFed: DateTime.now(),
            lastFedGrams: 50.0,
            dishFullness: 75.0,
            onDispensePressed: () {},
          ),
          const SizedBox(height: 16.0),
          const LiveCameraWidget(),
          const SizedBox(height: 16.0),
          const Row(
            children: [
              Expanded(
                child: EnvironmentStatsWidget(
                  type: EnvironmentStatsType.humidity,
                  value: 0.65,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: EnvironmentStatsWidget(
                  type: EnvironmentStatsType.foodLevel,
                  value: 0.39,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const DailySummaryWidget(),
        ],
      ),
    );
  }
}
