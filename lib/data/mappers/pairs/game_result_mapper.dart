import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';

final class GameResultMapper {
  GameResult fromJson(Map<String, dynamic> json) {
    return GameResult(
      secondsForGame: json[_Fields.secondsForGame],
      gameSecondsAmount: json[_Fields.gameSecondsAmount],
    );
  }

  Map<String, dynamic> toJson(GameResult data) {
    return {
      _Fields.secondsForGame: data.secondsForGame,
      _Fields.gameSecondsAmount: data.gameSecondsAmount,
    };
  }
}

abstract final class _Fields {
  static const secondsForGame = 'secondsForGame';
  static const gameSecondsAmount = 'gameSecondsAmount';
}
