part of 'schedule_bloc.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  final ScheduleStatus status;
  final List<ScheduleEntity> schedules;
  final String? errorMessage;

  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.schedules = const <ScheduleEntity>[],
    this.errorMessage,
  });

  ScheduleState copyWith({
    ScheduleStatus? status,
    List<ScheduleEntity>? schedules,
    String? errorMessage,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      schedules: schedules ?? this.schedules,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, schedules, errorMessage];
}
