import 'dart:async';
import 'dart:math';

import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/pairs/i_pairs_images_repository.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/logic/experience_calculator.dart';
import 'package:neuro_pairs/domain/utils/enums/categories_source_type.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';

final class PairsInteractor {
  final IPairsImagesRepository _pixabayImagesRepository;
  final IPairsImagesRepository _assetsImagesRepository;
  final IStatisticRepository _statisticRepository;
  final IAuthPreferencesRepository _authPreferencesRepository;

  PairsInteractor(
    this._pixabayImagesRepository,
    this._assetsImagesRepository,
    this._statisticRepository,
    this._authPreferencesRepository,
  );

  ({
    Experience currentExperience,
    Experience updatedExperience,
  }) calculateNewExperience({
    required PairsGame pairsGame,
    required List<GameResult> gameResults,
  }) {
    final statistic = _statisticRepository.statistic;

    if (statistic == null) {
      throw ArgumentError('statistic must not be null');
    }

    final currentExperience = statistic.experience;
    var updatedExperience = statistic.experience;

    for (final gameResult in gameResults) {
      updatedExperience = ExperienceCalculator(
        currentExperience: updatedExperience,
        pairsSettings: pairsGame.pairsGameSettings,
        gameResult: gameResult,
      ).calculateNewExperience();
    }

    return (
      currentExperience: currentExperience,
      updatedExperience: updatedExperience,
    );
  }

  Future<void> updatePassedGameStatistic({
    required PairsGame pairsGame,
    required List<GameResult> gameResults,
  }) async {
    final savedUserUid = _authPreferencesRepository.fetchUserUid();
    final statistic = _statisticRepository.statistic;

    if (savedUserUid == null) {
      throw ArgumentError('userUid must not be null');
    }

    if (statistic == null) {
      throw ArgumentError('statistic must not be null');
    }

    final gameStatisticUnit = GameStatisticUnit(
      pairsGame: pairsGame,
      gameResults: gameResults,
    );

    final updatedExperience = calculateNewExperience(
      pairsGame: pairsGame,
      gameResults: gameResults,
    ).updatedExperience;

    _statisticRepository.updatePassedGamesStatistic(
      userUid: savedUserUid,
      gameStatisticUnit: gameStatisticUnit,
      experience: updatedExperience,
    );
  }

  Future<Map<PairsCategoryType, List<String>>> fetchImagesForCategories({
    required Iterable<PairsCategoryType> categories,
    required int uniqueImagesAmount,
  }) async {
    final summaryCategoriesLength = categories.length;

    if (summaryCategoriesLength == 0 || categories.isEmpty) return {};

    final imagesAmountPerCategory =
        uniqueImagesAmount ~/ summaryCategoriesLength;

    final reminder = uniqueImagesAmount % summaryCategoriesLength;

    final categoriesImages = <PairsCategoryType, List<String>>{};

    final offlineCategories = categories.whereType<OfflinePairsCategoryType>();
    final onlineCategories = categories.whereType<OnlinePairsCategoryType>();

    final availableSourceTypes =
        categories.map((e) => e.categorySourceType).toList();
    final randomSourceType = availableSourceTypes[Random().nextInt(
      availableSourceTypes.length,
    )];

    final offlineImages = await _fetchAssetsImages(
      offlineCategories,
      imagesAmountPerCategory,
      randomSourceType == CategoriesSourceType.assets ? reminder : null,
    );

    final onlineImages = await _fetchPixabayImages(
      onlineCategories,
      imagesAmountPerCategory,
      randomSourceType == CategoriesSourceType.pixabay ? reminder : null,
    );

    categoriesImages.addAll({...offlineImages, ...onlineImages});

    return categoriesImages;
  }

  Future<Map<OfflinePairsCategoryType, List<String>>> _fetchAssetsImages(
    Iterable<OfflinePairsCategoryType> categories,
    int imagesAmountPerCategory, [
    int? reminder,
  ]) async {
    if (categories.isEmpty) return {};

    final maxIterations = categories.length;
    final randomReminderIterator = Random().nextInt(maxIterations);

    final result = <OfflinePairsCategoryType, List<String>>{};

    for (var index = 0; index < categories.length; index++) {
      var offlineCategory = categories.elementAt(index);

      final iterationImagesAmount = reminder == null
          ? imagesAmountPerCategory
          : index == randomReminderIterator
              ? imagesAmountPerCategory + reminder
              : imagesAmountPerCategory;

      final categoryImages = await _assetsImagesRepository.fetchRandomImages(
        categoryType: offlineCategory,
        quantity: iterationImagesAmount,
      );

      result[offlineCategory] = [...categoryImages, ...categoryImages];
    }

    return result;
  }

  Future<Map<OnlinePairsCategoryType, List<String>>> _fetchPixabayImages(
    Iterable<OnlinePairsCategoryType> categories,
    int imagesAmountPerCategory, [
    int? reminder,
  ]) async {
    if (categories.isEmpty) return {};

    final maxIterations = categories.length;
    final randomReminderIterator = Random().nextInt(maxIterations);

    final result = <OnlinePairsCategoryType, List<String>>{};

    for (var index = 0; index < categories.length; index++) {
      var onlineCategory = categories.elementAt(index);

      final iterationImagesAmount = reminder == null
          ? imagesAmountPerCategory
          : index == randomReminderIterator
              ? imagesAmountPerCategory + reminder
              : imagesAmountPerCategory;

      final categoryImages = await _pixabayImagesRepository.fetchRandomImages(
        categoryType: onlineCategory,
        quantity: iterationImagesAmount,
      );

      result[onlineCategory] = [...categoryImages, ...categoryImages];
    }

    return result;
  }
}
