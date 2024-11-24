import 'dart:isolate';

import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/utils/extensions/date_time_ext.dart';

typedef LastWeekStatistic = ({
  int summaryGamesAmount,
  int summarySecondsInGames,
  List<MapEntry<int, int>> gamesAmountPerDay,
});

typedef SummaryStatistic = ({
  int summaryGamesAmount,
  int summarySecondsInGames,
  Map<PairsGridType, int> gamesAmountByGridType,
});

final class StatisticCalculator {
  final List<GameStatisticUnit> gamesUnits;

  const StatisticCalculator({required this.gamesUnits});

  Future<SummaryStatistic> calculateSummaryStatistic() {
    return Isolate.run<SummaryStatistic>(_calculateSummaryStatistic);
  }

  Future<LastWeekStatistic> calculateLastWeekStatistic() {
    return Isolate.run<LastWeekStatistic>(_calculateLastWeekStatistic);
  }

  SummaryStatistic _calculateSummaryStatistic() {
    final summaryGamesAmount = _calculateSummaryGamesAmount();
    final summarySecondsInGames = _calculateSummarySecondsInGames();
    final gamesAmountByGridType = _calculateGamesAmountByGridType();

    return (
      summaryGamesAmount: summaryGamesAmount,
      summarySecondsInGames: summarySecondsInGames,
      gamesAmountByGridType: gamesAmountByGridType,
    );
  }

  LastWeekStatistic _calculateLastWeekStatistic() {
    final gamesAmountPerDay = calculateLastWeekGamesAmountPerDay();
    final summaryGamesAmount = calculateLastWeekSummaryGamesAmount();
    final summarySecondsInGames = _calculateLastWeekSummarySecondsInGames();

    return (
      summaryGamesAmount: summaryGamesAmount,
      summarySecondsInGames: summarySecondsInGames,
      gamesAmountPerDay: gamesAmountPerDay,
    );
  }

  List<MapEntry<int, int>> calculateLastWeekGamesAmountPerDay() {
    final now = DateTime.now().leaveDateOnly();

    final lastWeekGamesAmount = <MapEntry<int, int>>[];

    for (var index = 0; index < 7; index++) {
      final gamesForIndexedDay = gamesUnits.where(
        (game) => game.pairsGame.gameDateTime.leaveDateOnly().isAtSameMomentAs(
              now.copyWith(day: now.day - index),
            ),
      );

      final summaryGamesUnitForDay = gamesForIndexedDay.isEmpty
          ? 0
          : gamesForIndexedDay
              .map((e) => e.gameResults.length)
              .reduce((e1, e2) => e1 + e2);

      lastWeekGamesAmount.add(
        MapEntry(6 - index, summaryGamesUnitForDay),
      );
    }

    return lastWeekGamesAmount;
  }

  int calculateLastWeekSummaryGamesAmount() {
    final lastWeekGames = _lastWeekGames();

    var summaryGamesAmount = 0;

    for (final gameUnit in lastWeekGames) {
      summaryGamesAmount += gameUnit.gameResults.length;
    }

    return summaryGamesAmount;
  }

  int _calculateLastWeekSummarySecondsInGames() {
    final lastWeekGames = _lastWeekGames();

    var summarySecondsInGames = 0;

    for (final gameUnit in lastWeekGames) {
      summarySecondsInGames += gameUnit.gameResults
          .map((e) => e.gameSecondsAmount)
          .reduce((e1, e2) => e1 + e2);
    }

    return summarySecondsInGames;
  }

  int _calculateSummaryGamesAmount() {
    var summaryGamesAmount = 0;

    for (final gameUnit in gamesUnits) {
      summaryGamesAmount += gameUnit.gameResults.length;
    }

    return summaryGamesAmount;
  }

  int _calculateSummarySecondsInGames() {
    var summarySecondsInGames = 0;

    for (final gameUnit in gamesUnits) {
      summarySecondsInGames += gameUnit.gameResults
          .map((e) => e.gameSecondsAmount)
          .reduce((e1, e2) => e1 + e2);
    }

    return summarySecondsInGames;
  }

  Iterable<GameStatisticUnit> _lastWeekGames() {
    final now = DateTime.now();
    final weekBeforeDate = now.copyWith(day: now.day - 7);

    return gamesUnits.where(
      (unit) => unit.pairsGame.gameDateTime.isAfter(weekBeforeDate),
    );
  }

  Map<PairsGridType, int> _calculateGamesAmountByGridType() {
    final gamesAmountByGridType = Map.fromIterables(
      PairsGridType.values,
      List.generate(PairsGridType.values.length, (_) => 0),
    );

    for (final gameUnit in gamesUnits) {
      final gridType = gameUnit.pairsGame.pairsGameSettings.gridType;
      final currentGamesAmount = gamesAmountByGridType[gridType]!;
      final typedGamesAmount = gameUnit.gameResults.length;

      gamesAmountByGridType[gridType] = currentGamesAmount + typedGamesAmount;
    }

    return gamesAmountByGridType;
  }
}
