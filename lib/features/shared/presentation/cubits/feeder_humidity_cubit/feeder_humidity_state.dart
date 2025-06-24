part of 'feeder_humidity_cubit.dart';

class FeederHumidityState {
  final bool isLoading;
  final FeederHumidity? feederHumidity;

  const FeederHumidityState({this.isLoading = false, this.feederHumidity});

  FeederHumidityState copyWith({
    bool? isLoading,
    FeederHumidity? feederHumidity,
  }) {
    return FeederHumidityState(
      isLoading: isLoading ?? this.isLoading,
      feederHumidity: feederHumidity ?? this.feederHumidity,
    );
  }
}
