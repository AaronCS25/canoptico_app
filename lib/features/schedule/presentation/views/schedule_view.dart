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
        )..add(SchedulesFetched()),
        child: const _ScheduleViewBody(),
      ),
    );
  }
}

class _ScheduleViewBody extends StatelessWidget {
  const _ScheduleViewBody();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. El título se queda fijo en la parte superior
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
            child: Row(
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
          ),

          // 2. La lista ahora ocupará el espacio restante
          Expanded(
            child: BlocBuilder<ScheduleBloc, ScheduleState>(
              builder: (context, state) {
                if (state.status == ScheduleStatus.initial ||
                    state.status == ScheduleStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == ScheduleStatus.failure) {
                  return Center(child: Text('Error: ${state.errorMessage}'));
                }

                // --- LÓGICA MODIFICADA AQUÍ ---
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  // 3. El número de items es la lista + 1 (para el formulario)
                  itemCount: state.schedules.length + 1,
                  itemBuilder: (context, index) {
                    // 4. Si el índice es para el último item, muestra el formulario
                    if (index == state.schedules.length) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                        child: ScheduleAddItemWidget(),
                      );
                    }

                    // Si no, muestra un item de la lista de schedules
                    final schedule = state.schedules[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ScheduleItemWidget(
                        key: ValueKey(schedule.id),
                        schedule: schedule,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
