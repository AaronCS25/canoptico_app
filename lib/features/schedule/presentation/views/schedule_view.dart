import 'package:canoptico_app/features/schedule/schedule.dart';
import 'package:flutter/material.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _ScheduleViewBody());
  }
}

class _ScheduleViewBody extends StatelessWidget {
  const _ScheduleViewBody();

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
                Icons.calendar_month_outlined,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text("Active Schedules", style: theme.textTheme.headlineMedium),
            ],
          ),
          const SizedBox(height: 12),
          const ScheduleItemWidget(),
        ],
      ),
    );
  }
}
