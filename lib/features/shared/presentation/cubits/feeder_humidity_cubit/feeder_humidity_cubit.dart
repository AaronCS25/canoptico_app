import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/shared/shared.dart';

part 'feeder_humidity_state.dart';

class FeederHumidityCubit extends Cubit<FeederHumidityState> {
  final Future<FeederHumidity> Function() fetchFeederHumidityData;

  FeederHumidityCubit({required this.fetchFeederHumidityData})
    : super(const FeederHumidityState()) {
    fetchFeederHumidity();
  }

  Future<void> fetchFeederHumidity() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      final feederHumidity = await fetchFeederHumidityData();
      emit(state.copyWith(isLoading: false, feederHumidity: feederHumidity));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }
}
