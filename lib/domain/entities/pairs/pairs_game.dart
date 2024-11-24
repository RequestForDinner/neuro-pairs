import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

final class PairsGame {
  final DateTime gameDateTime;
  final PairsSettings pairsGameSettings;
  final List<PairsCategoryType> pairsCategories;

  const PairsGame({
    required this.gameDateTime,
    required this.pairsGameSettings,
    required this.pairsCategories,
  });
}
