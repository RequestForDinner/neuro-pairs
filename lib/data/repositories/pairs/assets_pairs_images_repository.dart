import 'dart:typed_data';

import 'package:neuro_pairs/data/data_sources/interfaces/i_pairs_images_data_source.dart';
import 'package:neuro_pairs/domain/interfaces/pairs/i_pairs_images_repository.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

final class AssetsPairsImagesRepository implements IPairsImagesRepository {
  final IPairsImagesDataSource _assetsPairsImagesDateSource;

  const AssetsPairsImagesRepository(this._assetsPairsImagesDateSource);

  @override
  Stream<int> get loadingEventStream =>
      _assetsPairsImagesDateSource.loadingEventStream;

  @override
  Future<List<String>> fetchRandomImages({
    required PairsCategoryType categoryType,
    required int quantity,
  }) {
    return _assetsPairsImagesDateSource.fetchRandomImages(
      categoryType: categoryType,
      quantity: quantity,
    );
  }
}
