import 'dart:math';

import 'package:neuro_pairs/data/data_sources/interfaces/i_pairs_images_data_source.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:neuro_pairs/domain/utils/offline_cards_assets.dart';

final class AssetsImagesDataSource implements IPairsImagesDataSource {
  @override
  Stream<int> get loadingEventStream => throw UnimplementedError();

  @override
  Future<List<String>> fetchRandomImages({
    required PairsCategoryType categoryType,
    required int quantity,
  }) async {
    try {
      if (categoryType is OnlinePairsCategoryType) {
        throw ArgumentError('Online categories must not be passed here.');
      }

      final availableAssets = OfflineCardsAssets.categoryAssets[categoryType]!;

      final uniqueRandomAssets = <String>{};

      while (uniqueRandomAssets.length != quantity) {
        final randomInt = Random().nextInt(availableAssets.length);

        uniqueRandomAssets.add(availableAssets[randomInt]);
      }

      return uniqueRandomAssets.toList();
    } on Object catch (e) {
      return [];
    }
  }
}
