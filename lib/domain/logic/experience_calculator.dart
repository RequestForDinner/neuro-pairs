import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/utils/experience_levels.dart';

final class ExperienceCalculator {
  final Experience currentExperience;
  final PairsSettings pairsSettings;
  final GameResult gameResult;

  const ExperienceCalculator({
    required this.currentExperience,
    required this.pairsSettings,
    required this.gameResult,
  });

  Experience calculateNewExperience() {
    final experienceToAdd = _calculateExperienceValue();
    const availableLevels = ExperienceLevels.availableLevels;

    final updatedExpValue =
        currentExperience.currentExperience + experienceToAdd;
    final clampedExpValue = updatedExpValue.clamp(
      currentExperience.currentExperience,
      availableLevels.values.last,
    );

    var needExperienceLevel = 0;
    for (final level in availableLevels.keys) {
      final levelExp = availableLevels[level]!;

      if (clampedExpValue < levelExp) break;
      needExperienceLevel = level;
    }

    final nextLevelExperience = needExperienceLevel == availableLevels.keys.last
        ? availableLevels.values.last
        : availableLevels[needExperienceLevel + 1];

    availableLevels[nextLevelExperience];

    final updatedExperience = currentExperience.copyWith(
      startCurrentLevelExperience: availableLevels[needExperienceLevel],
      currentLevel: needExperienceLevel,
      nextLevelExperience: nextLevelExperience,
      currentExperience: clampedExpValue,
    );

    return updatedExperience;
  }

  int _calculateExperienceValue() {
    var receivedExperience = _baseExperienceForGridType();

    receivedExperience =
        pairsSettings.needTime && gameResult.gameSecondsAmount != 0
            ? receivedExperience + _calculateExperienceForTime()
            : receivedExperience ~/ 2;

    if (pairsSettings.needTime && pairsSettings.timeHardMode) {
      receivedExperience += _calculateExperienceForHardMode();
    }

    return receivedExperience;
  }

  int _calculateExperienceForTime() {
    if (gameResult.secondsForGame - gameResult.gameSecondsAmount <= 0 ||
        gameResult.gameSecondsAmount == 0) {
      return 0;
    }

    final maxSecondsForGridType = _maxSecondsForGridType(
      pairsSettings.gridType,
    );

    final expCoefficient =
        (maxSecondsForGridType - gameResult.secondsForGame) / 100;

    final expForAdd = ((maxSecondsForGridType - gameResult.gameSecondsAmount) *
            expCoefficient) /
        10;

    return expForAdd.floor();
  }

  int _calculateExperienceForHardMode() {
    if (gameResult.secondsForGame - gameResult.gameSecondsAmount <= 0 ||
        gameResult.gameSecondsAmount == 0) {
      return 0;
    }

    const baseHardModeExp = 20;
    final maxSecondsForGridType = _maxSecondsForGridType(
      pairsSettings.gridType,
    );
    final expCoefficient =
        (maxSecondsForGridType - gameResult.secondsForGame) / 100;

    final expForTime = ((maxSecondsForGridType - gameResult.gameSecondsAmount) *
            expCoefficient) /
        100;

    final expForAdd = baseHardModeExp + expForTime;

    return expForAdd.floor();
  }

  int _baseExperienceForGridType() {
    return switch (pairsSettings.gridType) {
      PairsGridType.threeXFour => 20,
      PairsGridType.fourXFour => 40,
      PairsGridType.fourXFive => 60,
      PairsGridType.fourXSix => 80,
      PairsGridType.fourXSeven => 120,
      PairsGridType.sixXSix => 140,
    };
  }

  int _maxSecondsForGridType(PairsGridType gridType) {
    return switch (gridType) {
      PairsGridType.threeXFour => 80,
      PairsGridType.fourXFour => 159,
      PairsGridType.fourXFive => 239,
      PairsGridType.fourXSix => 299,
      PairsGridType.fourXSeven => 359,
      PairsGridType.sixXSix => 400,
    };
  }

  double _calculatePercentagePassedTime() {
    final secondsDiv = gameResult.gameSecondsAmount / gameResult.secondsForGame;

    return (100 - ((secondsDiv) * 100)) / 100;
  }
}
