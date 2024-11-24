part of 'pairs_categories_cubit.dart';

final class PairsCategoriesState {
  final List<PairsCategoryType> categoriesTypes;
  final PairsSettings pairsSettings;
  final bool canAddNewCategory;

  final bool canSelectOnlineCategories;

  const PairsCategoriesState({
    required this.pairsSettings,
    this.categoriesTypes = const [],
    this.canAddNewCategory = true,
    this.canSelectOnlineCategories = true,
  });

  factory PairsCategoriesState.init() => PairsCategoriesState(
        pairsSettings: PairsSettings.defaultSettings(),
      );

  PairsCategoriesState copyWith({
    List<PairsCategoryType>? categoriesTypes,
    PairsSettings? pairsSettings,
    bool? canAddNewCategory,
    bool? canSelectOnlineCategories,
  }) {
    return PairsCategoriesState(
      categoriesTypes: categoriesTypes ?? this.categoriesTypes,
      pairsSettings: pairsSettings ?? this.pairsSettings,
      canAddNewCategory: canAddNewCategory ?? this.canAddNewCategory,
      canSelectOnlineCategories:
          canSelectOnlineCategories ?? this.canSelectOnlineCategories,
    );
  }
}
