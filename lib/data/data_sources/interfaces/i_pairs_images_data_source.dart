import 'dart:typed_data';

import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

abstract interface class IPairsImagesDataSource {
  Stream<int> get loadingEventStream;

  Future<List<String>> fetchRandomImages({
    required PairsCategoryType categoryType,
    required int quantity,
  });
}
