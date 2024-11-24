import 'package:neuro_pairs/data/mappers/pairs/game_result_mapper.dart';
import 'package:neuro_pairs/data/mappers/pairs/pairs_game_mapper.dart';
import 'package:neuro_pairs/data/mappers/statistic/experience_mapper.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';

final class StatisticMapper {
  Statistic fromJson(Map<String, dynamic> json) {
    final gameStatisticUnitMapper = GameStatisticUnitMapper();

    final gamesStatisticUnitsJsonsList =
        json[_StatisticFields.gamesStatisticUnits] as List<dynamic>;
    final gamesStatisticUnits = gamesStatisticUnitsJsonsList.map(
      (e) => gameStatisticUnitMapper.fromJson(e),
    );

    final experience = ExperienceMapper().fromJson(
      json[_StatisticFields.experience],
    );

    return Statistic(
      experience: experience,
      gamesStatisticUnits: gamesStatisticUnits.toList(),
    );
  }

  Map<String, dynamic> toJson(Statistic data) {
    final gameStatisticUnitMapper = GameStatisticUnitMapper();
    final gamesStatisticUnitsJsons = data.gamesStatisticUnits.map(
      gameStatisticUnitMapper.toJson,
    );

    final experienceJson = ExperienceMapper().toJson(data.experience);

    return {
      _StatisticFields.experience: experienceJson,
      _StatisticFields.gamesStatisticUnits: gamesStatisticUnitsJsons.toList(),
    };
  }
}

final class GameStatisticUnitMapper {
  GameStatisticUnit fromJson(Map<String, dynamic> json) {
    final pairsGameMapper = PairsGameMapper();
    final pairsGame = pairsGameMapper.fromJson(
      json[_GameStatisticUnitFields.pairsGame],
    );

    final gameResultMapper = GameResultMapper();
    final gamesResultsJsonsList =
        json[_GameStatisticUnitFields.gamesResults] as List<dynamic>;
    final gamesResults = gamesResultsJsonsList.map(
      (e) => gameResultMapper.fromJson(e),
    );

    return GameStatisticUnit(
      pairsGame: pairsGame,
      gameResults: gamesResults.toList(),
    );
  }

  Map<String, dynamic> toJson(GameStatisticUnit data) {
    final pairsGame = PairsGameMapper().toJson(data.pairsGame);

    final gameResultMapper = GameResultMapper();
    final gamesResultsJsons = data.gameResults.map(gameResultMapper.toJson);

    return {
      _GameStatisticUnitFields.pairsGame: pairsGame,
      _GameStatisticUnitFields.gamesResults: gamesResultsJsons,
    };
  }
}

abstract final class _StatisticFields {
  static const experience = 'experience';
  static const gamesStatisticUnits = 'gamesStatisticUnits';
}

abstract final class _GameStatisticUnitFields {
  static const pairsGame = 'pairsGame';
  static const gamesResults = 'gamesResults';
}
