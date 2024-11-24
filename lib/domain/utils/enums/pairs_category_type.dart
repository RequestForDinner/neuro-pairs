import 'package:neuro_pairs/domain/utils/enums/categories_source_type.dart';

sealed class PairsCategoryType {
  String get stringName;

  CategoriesSourceType get categorySourceType;
}

enum OfflinePairsCategoryType implements PairsCategoryType {
  figures(CategoriesSourceType.assets),
  colors(CategoriesSourceType.assets),
  numbersAndLetters(CategoriesSourceType.assets),
  countryFlags(CategoriesSourceType.assets);

  final CategoriesSourceType sourceType;

  const OfflinePairsCategoryType(this.sourceType);

  @override
  String get stringName => name;

  @override
  CategoriesSourceType get categorySourceType => sourceType;

  static OfflinePairsCategoryType categoryTypeFromString(
    String categoryTypeName,
  ) {
    return OfflinePairsCategoryType.values.firstWhere(
      (categoryType) => categoryType.name == categoryTypeName,
      orElse: () => throw UnimplementedError(
        '$categoryTypeName not contain in offline categories',
      ),
    );
  }
}

enum OnlinePairsCategoryType implements PairsCategoryType {
  sport(CategoriesSourceType.pixabay),
  vehicle(CategoriesSourceType.pixabay),
  plants(CategoriesSourceType.pixabay),
  science(CategoriesSourceType.pixabay),
  music(CategoriesSourceType.pixabay),
  animals(CategoriesSourceType.pixabay);

  final CategoriesSourceType sourceType;

  const OnlinePairsCategoryType(this.sourceType);

  @override
  String get stringName => name;

  @override
  CategoriesSourceType get categorySourceType => sourceType;

  static OnlinePairsCategoryType categoryTypeFromString(
    String categoryTypeName,
  ) {
    return OnlinePairsCategoryType.values.firstWhere(
      (categoryType) => categoryType.name == categoryTypeName,
      orElse: () => throw UnimplementedError(
        '$categoryTypeName not contain in online categories',
      ),
    );
  }
}
