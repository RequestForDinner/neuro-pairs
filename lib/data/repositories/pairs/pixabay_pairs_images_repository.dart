import 'dart:typed_data';

import 'package:neuro_pairs/data/data_sources/interfaces/i_pairs_images_data_source.dart';
import 'package:neuro_pairs/domain/interfaces/pairs/i_pairs_images_repository.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

final class PixabayPairsImagesRepository implements IPairsImagesRepository {
  final IPairsImagesDataSource _pairsImagesDataSource;

  const PixabayPairsImagesRepository(this._pairsImagesDataSource);

  @override
  Stream<int> get loadingEventStream =>
      _pairsImagesDataSource.loadingEventStream;

  @override
  Future<List<String>> fetchRandomImages({
    required PairsCategoryType categoryType,
    required int quantity,
  }) {
    return _pairsImagesDataSource.fetchRandomImages(
      categoryType: categoryType,
      quantity: quantity,
    );
  }
}
