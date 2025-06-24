import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:canoptico_app/features/shared/shared.dart';

part 'bowl_food_state.dart';

class BowlFoodCubit extends Cubit<BowlFoodState> {
  Future<BowlFood> Function() fetchBowlData;

  BowlFoodCubit({required this.fetchBowlData}) : super(const BowlFoodState()) {
    fetchBowlFood();
  }

  Future<void> fetchBowlFood() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true));

    try {
      final bowlFood = await fetchBowlData();
      emit(state.copyWith(isLoading: false, bowlFood: bowlFood));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      rethrow;
    }
  }
}
