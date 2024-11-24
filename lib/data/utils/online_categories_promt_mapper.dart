import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

extension OnlineCategoriesPromtMapper on OnlinePairsCategoryType {
  String searchPromtFromCategoryType() {
    return switch (this) {
      OnlinePairsCategoryType.music => 'Music',
      OnlinePairsCategoryType.plants => 'Plants',
      OnlinePairsCategoryType.science => 'Science',
      OnlinePairsCategoryType.sport => 'Sport',
      OnlinePairsCategoryType.vehicle => 'Vehicle',
      OnlinePairsCategoryType.animals => 'Animals',
    };
  }
}
