import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/schedule/schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository _scheduleRepository;

  ScheduleBloc({required ScheduleRepository scheduleRepository})
    : _scheduleRepository = scheduleRepository,
      super(const ScheduleState()) {
    // Registrar los manejadores de eventos
    on<SchedulesFetched>(_onSchedulesFetched);
    on<ScheduleCreated>(_onScheduleCreated);
    on<ScheduleUpdated>(_onScheduleUpdated);
    // on<ScheduleDeleted>(_onScheduleDeleted); // Si decides implementarlo
  }

  // Manejador para obtener la lista de schedules
  Future<void> _onSchedulesFetched(
    SchedulesFetched event,
    Emitter<ScheduleState> emit,
  ) async {
    emit(state.copyWith(status: ScheduleStatus.loading));
    try {
      final schedules = await _scheduleRepository.getSchedules();
      emit(
        state.copyWith(status: ScheduleStatus.success, schedules: schedules),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ScheduleStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // Manejador para crear un nuevo schedule
  Future<void> _onScheduleCreated(
    ScheduleCreated event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      final newSchedule = await _scheduleRepository.createSchedule(
        event.scheduleData,
      );
      // Agrega el nuevo schedule a la lista actual y emite el estado de éxito
      final updatedList = List<ScheduleEntity>.from(state.schedules)
        ..add(newSchedule);
      emit(
        state.copyWith(status: ScheduleStatus.success, schedules: updatedList),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ScheduleStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // Manejador para actualizar un schedule
  Future<void> _onScheduleUpdated(
    ScheduleUpdated event,
    Emitter<ScheduleState> emit,
  ) async {
    try {
      final updatedSchedule = await _scheduleRepository.updateSchedule(
        event.scheduleId,
        event.scheduleData,
      );
      // Reemplaza el schedule antiguo con el actualizado en la lista
      final updatedList = state.schedules.map((schedule) {
        return schedule.id == event.scheduleId ? updatedSchedule : schedule;
      }).toList();
      emit(
        state.copyWith(status: ScheduleStatus.success, schedules: updatedList),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ScheduleStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
