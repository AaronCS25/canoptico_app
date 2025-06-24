import 'package:canoptico_app/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/shared/shared.dart';
import 'package:canoptico_app/features/dashboard/dashboard.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeederHumidityCubit(
            fetchFeederHumidityData:
                ServiceLocator.get<DeviceStatusRepository>().getFeederHumidity,
          ),
        ),
        BlocProvider(
          create: (context) => FeederLevelCubit(
            fetchFeederLevelData:
                ServiceLocator.get<DeviceStatusRepository>().getFeederLevel,
          ),
        ),
      ],
      child: const _DashboardViewBody(),
    );
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
          Row(
            children: [
              Expanded(
                child: BlocBuilder<FeederHumidityCubit, FeederHumidityState>(
                  builder: (context, state) {
                    return EnvironmentStatsWidget(
                      type: EnvironmentStatsType.humidity,
                      value: state.feederHumidity?.humidity ?? 0.0,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: BlocBuilder<FeederLevelCubit, FeederLevelState>(
                  builder: (context, state) {
                    return EnvironmentStatsWidget(
                      type: EnvironmentStatsType.foodLevel,
                      value: state.feederLevel?.amount ?? 0.0,
                    );
                  },
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
