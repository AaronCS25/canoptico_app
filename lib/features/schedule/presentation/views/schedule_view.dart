import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ScheduleBloc(
          scheduleRepository: ServiceLocator.get<ScheduleRepository>(),
        ),
        child: const _ScheduleViewBody(),
      ),
    );
  }
}

class _ScheduleViewBody extends StatelessWidget {
  const _ScheduleViewBody();

  @override
  Widget build(BuildContext context) {
    // Es una buena práctica añadir el evento para cargar los datos aquí
    context.read<ScheduleBloc>().add(SchedulesFetched());

    final theme = Theme.of(context);
    final scheduleList = context.watch<ScheduleBloc>().state.schedules;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text("Active Schedules", style: theme.textTheme.headlineMedium),
            ],
          ),
          const SizedBox(height: 12),

          ...scheduleList.map((schedule) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ScheduleItemWidget(schedule: schedule),
            );
          }),
        ],
      ),
    );
  }
}
