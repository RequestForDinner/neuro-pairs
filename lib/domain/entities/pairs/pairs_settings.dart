final class PairsSettings {
  final PairsGridType gridType;
  final bool needTime;
  final bool timeHardMode;
  final int secondsForGame;

  const PairsSettings({
    required this.gridType,
    required this.needTime,
    required this.timeHardMode,
    required this.secondsForGame,
  });

  factory PairsSettings.defaultSettings() => const PairsSettings(
        gridType: PairsGridType.fourXFour,
        needTime: true,
        timeHardMode: false,
        secondsForGame: 120,
      );

  PairsSettings copyWith({
    PairsGridType? gridType,
    bool? needTime,
    bool? timeHardMode,
    int? secondsForGame,
  }) {
    return PairsSettings(
      gridType: gridType ?? this.gridType,
      needTime: needTime ?? this.needTime,
      timeHardMode: timeHardMode ?? this.timeHardMode,
      secondsForGame: secondsForGame ?? this.secondsForGame,
    );
  }
}

enum PairsGridType {
  threeXFour(6),
  fourXFour(8),
  fourXFive(10),
  fourXSix(12),
  fourXSeven(14),
  sixXSix(18);

  final int uniqueCards;

  const PairsGridType(this.uniqueCards);

  static PairsGridType gridTypeFromString(String pairsGridTypeName) {
    return PairsGridType.values.firstWhere(
      (gridType) => gridType.name == pairsGridTypeName,
      orElse: () => throw UnimplementedError(),
    );
  }
}
