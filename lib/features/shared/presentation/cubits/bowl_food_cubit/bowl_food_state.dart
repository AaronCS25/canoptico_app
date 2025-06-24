part of 'bowl_food_cubit.dart';

class BowlFoodState {
  final bool isLoading;
  final BowlFood? bowlFood;

  const BowlFoodState({this.isLoading = false, this.bowlFood});

  BowlFoodState copyWith({bool? isLoading, BowlFood? bowlFood}) {
    return BowlFoodState(
      isLoading: isLoading ?? this.isLoading,
      bowlFood: bowlFood ?? this.bowlFood,
    );
  }
}
