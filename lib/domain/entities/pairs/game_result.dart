final class GameResult {
  final int secondsForGame;
  final int gameSecondsAmount;

  const GameResult({
    required this.secondsForGame,
    this.gameSecondsAmount = 0,
  });

  GameResult copyWith({
    int? secondsForGame,
    int? gameSecondsAmount,
  }) {
    return GameResult(
      secondsForGame: secondsForGame ?? this.secondsForGame,
      gameSecondsAmount: gameSecondsAmount ?? this.gameSecondsAmount,
    );
  }
}
