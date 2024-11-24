import 'package:neuro_pairs/data/mappers/pairs/pairs_settings_mapper.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

final class PairsGameMapper {
  PairsGame fromJson(Map<String, dynamic> json) {
    final pairsSettingMapper = PairsSettingsMapper();

    final categoriesTypesJsons = json[_Fields.pairsCategories] as List<dynamic>;

    final categoriesTypes = categoriesTypesJsons.map<PairsCategoryType>((e) {
      try {
        final offlineCategoryType =
            OfflinePairsCategoryType.categoryTypeFromString(e.toString());

        return offlineCategoryType;
      } on Object catch (_) {
        final onlineCategoryType =
            OnlinePairsCategoryType.categoryTypeFromString(e.toString());

        return onlineCategoryType;
      }
    });

    return PairsGame(
      gameDateTime: DateTime.parse(json[_Fields.gameDateTime]),
      pairsGameSettings: pairsSettingMapper.fromJson(
        json[_Fields.pairsSettings],
      ),
      pairsCategories: categoriesTypes.toList(),
    );
  }

  Map<String, dynamic> toJson(PairsGame data) {
    final pairsSettingsMapper = PairsSettingsMapper();
    final castedCategoriesTypes = data.pairsCategories.map((e) => e.stringName);

    return {
      _Fields.gameDateTime: data.gameDateTime.toString(),
      _Fields.pairsCategories: castedCategoriesTypes.toList(),
      _Fields.pairsSettings: pairsSettingsMapper.toJson(data.pairsGameSettings),
    };
  }
}

abstract final class _Fields {
  static const gameDateTime = 'gameDateTime';
  static const pairsSettings = 'pairsGameSettings';
  static const pairsCategories = 'pairsCategories';
}
