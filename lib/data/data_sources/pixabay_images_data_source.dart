import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:neuro_pairs/data/data_sources/interfaces/i_pairs_images_data_source.dart';
import 'package:neuro_pairs/data/utils/online_categories_promt_mapper.dart';
import 'package:neuro_pairs/domain/utils/app_logger.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:rxdart/rxdart.dart';

final class PixabayPairsImagesDataSource implements IPairsImagesDataSource {
  final _loadingEventSubject = BehaviorSubject<int>();

  static const _mainUrl = 'https://pixabay.com/api/';
  static const _apiKey = '45320888-494618d1accb618367100add5';

  @override
  Stream<int> get loadingEventStream => _loadingEventSubject;

  @override
  Future<List<String>> fetchRandomImages({
    required PairsCategoryType categoryType,
    required int quantity,
  }) async {
    try {
      final search = (categoryType as OnlinePairsCategoryType)
          .searchPromtFromCategoryType();
      final requestUrl = '$_mainUrl/?key=$_apiKey&orientation=vertical'
          '&q=$search&lang=en&image_type=photo&per_page=200';

      final response = await http.get(Uri.parse(requestUrl));

      final decodedBody = jsonDecode(response.body);

      final responseHits =
          (decodedBody as Map<String, dynamic>)['hits'] as List<dynamic>;
      final imagesUrls = responseHits.map(
        (e) => (e as Map<String, dynamic>)['webformatURL'].toString(),
      );

      if (imagesUrls.length < quantity) {
        throw ArgumentError();
      }

      final uniqueLimitedUrls = <String>{};

      while (uniqueLimitedUrls.length != quantity) {
        final randomNum = Random().nextInt(imagesUrls.length);

        uniqueLimitedUrls.add(imagesUrls.elementAt(randomNum));
      }

      return uniqueLimitedUrls.toList();
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Smt went wrong (Pixabay)',
        error: e,
        stackTrace: stackTrace,
      );

      return [];
    }
  }

  Future<http.Response> _fetchImageBytes({required String url}) async {
    try {
      final uri = Uri.parse(url);

      return http.get(uri);
    } on Object catch (e) {
      rethrow;
    }
  }
}
