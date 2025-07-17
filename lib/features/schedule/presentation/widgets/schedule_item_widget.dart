import 'package:canoptico_app/config/config.dart'; // Para HumanFormats
import 'package:canoptico_app/features/schedule/schedule.dart'; // Para Entidad y BLoC
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ScheduleItemWidget extends StatelessWidget {
  // 1. Acepta el objeto ScheduleEntity
  final ScheduleEntity schedule;

  const ScheduleItemWidget({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // 2. Usa tu wrapper para formatear la hora
    final formattedTime = HumanFormats.formatTime(schedule.scheduleTime);

    // Método para crear el mapa de datos para la actualización
    Map<String, dynamic> createUpdateData({
      bool? newActiveState,
      bool? newConditionalState,
      double? newConditionValue,
    }) {
      return {
        'amount': schedule.amount.toInt(),
        'hour': schedule.scheduleTime.hour,
        'minute': schedule.scheduleTime.minute,
        'active': newActiveState ?? schedule.isActive,
        'conditional': newConditionalState ?? schedule.isConditional,
        'conditional_amount':
            newConditionValue?.toInt() ?? schedule.conditionValue.toInt(),
        'timezone':
            'America/Lima', // O obtenerlo de una fuente de configuración
      };
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withAlpha(
                      (255 * 0.10).toInt(),
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(
                    Icons.watch_later_outlined,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Muestra la hora y cantidad dinámicas
                    Text(formattedTime, style: theme.textTheme.headlineMedium),
                    Text(
                      "${schedule.amount.toInt()}g",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Spacer(),
                // 4. Muestra la etiqueta "Active" solo si está activo
                if (schedule.isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDark
                          ? const Color(0xFFF97415)
                          : const Color(0xFFF97316),
                    ),
                    child: Text(
                      "Active",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? const Color(0xFF0F172A)
                            : const Color(0xFFF8FAFC),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                // 5. Botón de eliminar con confirmación
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Delete Schedule'),
                        content: Text(
                          'Are you sure you want to delete the $formattedTime schedule?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(dialogContext).pop(),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () {
                              // TODO: Implementar la lógica de eliminación
                              // context.read<ScheduleBloc>().add(
                              //   ScheduleDeleted(schedule.id),
                              // );
                              context.pop();
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline_outlined, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // 6. Switch conectado al estado y BLoC
                Switch(
                  value: schedule.isConditional,
                  onChanged: (bool value) {
                    final updatedData = createUpdateData(
                      newConditionalState: value,
                    );
                    // TODO: Implementar la lógica de actualización del estado
                    context.read<ScheduleBloc>().add(
                      ScheduleUpdated(schedule.id, updatedData),
                    );
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  "Conditional Dispensing",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? const Color(0xFFF8FAFC) : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            if (schedule.isConditional) ...[
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF101929)
                      : const Color(0xFFFAFAF9),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.dividerColor),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Only dispense if dish is below:",
                          style: theme.textTheme.bodySmall,
                        ),
                        Text(
                          "${schedule.conditionValue.toInt()}%",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? const Color(0xFFF8FAFC)
                                : const Color(0xFF020817),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Slider(
                      padding: EdgeInsets.zero,
                      divisions: 10,
                      value: schedule.conditionValue / 100,
                      onChanged: (value) {
                        // TODO: Implementar la lógica de actualización del valor
                      },
                      onChangeEnd: (value) {
                        final updatedData = createUpdateData(
                          newConditionValue: value * 100,
                        );
                        // TODO: Implementar la lógica de actualización del valor
                        context.read<ScheduleBloc>().add(
                          ScheduleUpdated(schedule.id, updatedData),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Will only dispense if dish is less than ${schedule.conditionValue.toInt()}% full",
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
