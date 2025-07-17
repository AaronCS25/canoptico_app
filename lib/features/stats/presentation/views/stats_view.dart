import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/stats/stats.dart';
import 'package:canoptico_app/features/shared/shared.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

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
      child: const Scaffold(body: _StatsViewBody()),
    );
  }
}

class _StatsViewBody extends StatelessWidget {
  const _StatsViewBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
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
          BlocBuilder<FeederHumidityCubit, FeederHumidityState>(
            builder: (context, state) {
              return EnvironmentWidget(
                humidity: state.feederHumidity?.humidity ?? 0.0,
              );
            },
          ),

          const SizedBox(height: 16.0),

          // food level
          BlocBuilder<FeederLevelCubit, FeederLevelState>(
            builder: (context, state) {
              return FoodLevelWidget(
                foodLevel: state.feederLevel?.amount ?? 0.0,
              );
            },
          ),
        ],
      ),
    );
  }
}
