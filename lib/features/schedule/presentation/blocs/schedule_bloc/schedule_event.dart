part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object> get props => [];
}

// Evento para cargar los schedules iniciales
class SchedulesFetched extends ScheduleEvent {}

// Evento para crear un nuevo schedule
class ScheduleCreated extends ScheduleEvent {
  final Map<String, dynamic> scheduleData;

  const ScheduleCreated(this.scheduleData);

  @override
  List<Object> get props => [scheduleData];
}

// Evento para actualizar un schedule existente
class ScheduleUpdated extends ScheduleEvent {
  final String scheduleId;
  final Map<String, dynamic> scheduleData;

  const ScheduleUpdated(this.scheduleId, this.scheduleData);

  @override
  List<Object> get props => [scheduleId, scheduleData];
}

// (Opcional) Evento para eliminar un schedule
class ScheduleDeleted extends ScheduleEvent {
  final String scheduleId;

  const ScheduleDeleted(this.scheduleId);

  @override
  List<Object> get props => [scheduleId];
}
