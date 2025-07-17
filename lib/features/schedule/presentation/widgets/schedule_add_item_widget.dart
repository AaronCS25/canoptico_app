import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/config/config.dart';
import 'package:canoptico_app/features/schedule/schedule.dart';

class ScheduleAddItemWidget extends StatefulWidget {
  const ScheduleAddItemWidget({super.key});

  @override
  State<ScheduleAddItemWidget> createState() => _ScheduleAddItemWidgetState();
}

class _ScheduleAddItemWidgetState extends State<ScheduleAddItemWidget> {
  // Clave para validar el formulario
  final _formKey = GlobalKey<FormState>();

  // Controladores y variables de estado para los campos del formulario
  TimeOfDay? _selectedTime;
  final TextEditingController _amountController = TextEditingController();
  bool _isConditional = false;
  double _conditionalValue = 20.0; // Valor inicial del slider en porcentaje

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Valida el formulario y que se haya seleccionado una hora
    if (_formKey.currentState!.validate() && _selectedTime != null) {
      // Construye el mapa de datos para el API
      final scheduleData = {
        'amount': int.tryParse(_amountController.text) ?? 0,
        'hour': _selectedTime!.hour,
        'minute': _selectedTime!.minute,
        'active': true, // Los nuevos schedules suelen empezar activos
        'conditional': _isConditional,
        'conditional_amount': _conditionalValue.toInt(),
        'timezone': 'America/Lima', // O una zona horaria de configuración
      };

      // Envía el evento al BLoC para crear el nuevo schedule
      context.read<ScheduleBloc>().add(ScheduleCreated(scheduleData));

      // Opcional: Limpiar el formulario después de enviar
      _formKey.currentState!.reset();
      setState(() {
        _selectedTime = null;
        _amountController.clear();
        _isConditional = false;
      });
    } else if (_selectedTime == null) {
      // Muestra un mensaje si no se seleccionó la hora
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a time')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Form(
      key: _formKey,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.add, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text("Add New Schedule", style: theme.textTheme.titleLarge),
                ],
              ),
              const SizedBox(height: 16),

              // --- Campo de Hora ---
              Text("Time", style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: _selectedTime == null
                      ? '--:--'
                      : HumanFormats.formatTime(_selectedTime!.toDateTime()),
                  suffixIcon: const Icon(Icons.watch_later_outlined),
                ),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() => _selectedTime = time);
                  }
                },
              ),
              const SizedBox(height: 16),

              // --- Campo de Cantidad ---
              Text("Amount", style: theme.textTheme.labelLarge),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'e.g., 50g'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // --- Switch Condicional ---
              Row(
                children: [
                  Switch(
                    value: _isConditional,
                    onChanged: (value) =>
                        setState(() => _isConditional = value),
                  ),
                  const SizedBox(width: 8),
                  const Text("Conditional Dispensing"),
                ],
              ),

              // --- Panel Condicional ---
              if (_isConditional) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF101929)
                        : const Color(0xFFFAFAF9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Only dispense if dish is below:"),
                          Text(
                            "${_conditionalValue.toInt()}%",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Slider(
                        value: _conditionalValue,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: "${_conditionalValue.toInt()}%",
                        onChanged: (value) =>
                            setState(() => _conditionalValue = value),
                      ),
                      Text(
                        "Will only dispense if dish is less than ${_conditionalValue.toInt()}% full",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // --- Botón de Añadir ---
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Schedule'),
                  onPressed: _submitForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Pequeña extensión para convertir TimeOfDay a DateTime para poder formatearlo
extension on TimeOfDay {
  DateTime toDateTime() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }
}
