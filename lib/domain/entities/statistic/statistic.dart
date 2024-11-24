import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';

final class Statistic {
  final Experience experience;
  final List<GameStatisticUnit> gamesStatisticUnits;

  const Statistic({
    required this.experience,
    required this.gamesStatisticUnits,
  });

  factory Statistic.empty() => Statistic(
        gamesStatisticUnits: [],
        experience: Experience.begin(),
      );

  Statistic copyWith({
    String? userUid,
    List<GameStatisticUnit>? gamesStatisticUnits,
    Experience? experience,
  }) {
    return Statistic(
      gamesStatisticUnits: gamesStatisticUnits ?? this.gamesStatisticUnits,
      experience: experience ?? this.experience,
    );
  }
}

final class GameStatisticUnit {
  final PairsGame pairsGame;
  final List<GameResult> gameResults;

  const GameStatisticUnit({
    required this.pairsGame,
    required this.gameResults,
  });

  GameStatisticUnit copyWith({
    PairsGame? pairsGame,
    List<GameResult>? gamesResults,
  }) {
    return GameStatisticUnit(
      pairsGame: pairsGame ?? this.pairsGame,
      gameResults: gamesResults ?? this.gameResults,
    );
  }
}
