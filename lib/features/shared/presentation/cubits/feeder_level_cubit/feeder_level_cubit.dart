import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/shared/shared.dart';

part 'feeder_level_state.dart';

class FeederLevelCubit extends Cubit<FeederLevelState> {
  final Future<FeederLevel> Function() fetchFeederLevelData;

  FeederLevelCubit({required this.fetchFeederLevelData})
    : super(const FeederLevelState()) {
    fetchFeederLevel();
  }

  Future<void> fetchFeederLevel() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      final feederLevel = await fetchFeederLevelData();
      emit(state.copyWith(isLoading: false, feederLevel: feederLevel));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }
}
