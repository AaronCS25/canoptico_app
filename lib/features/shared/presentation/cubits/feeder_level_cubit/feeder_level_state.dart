part of 'feeder_level_cubit.dart';

class FeederLevelState {
  final bool isLoading;
  final FeederLevel? feederLevel;

  const FeederLevelState({this.isLoading = false, this.feederLevel});

  FeederLevelState copyWith({bool? isLoading, FeederLevel? feederLevel}) {
    return FeederLevelState(
      isLoading: isLoading ?? this.isLoading,
      feederLevel: feederLevel ?? this.feederLevel,
    );
  }
}
