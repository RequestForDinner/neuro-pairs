import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/interactors/pairs/pairs_interactor.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:neuro_pairs/domain/utils/uid_generator.dart';
import 'package:neuro_pairs/presentation/pages/pairs/entities/card_entity.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';

part 'pairs_state.dart';

class PairsCubit extends Cubit<PairsState> {
  final PairsInteractor _pairsInteractor;

  PairsCubit(this._pairsInteractor) : super(PairsState.init());

  Future<void> updatePassedGameStatistic([List<GameResult>? gamesResults]) {
    return _pairsInteractor.updatePassedGameStatistic(
      pairsGame: state.pairsGame!,
      gameResults: gamesResults ?? state.gamesResults,
    );
  }

  void updateNeedShowEndFinishBody({bool needShowEndFinishBody = false}) {
    emit(state.copyWith(needShowEndFinishBody: needShowEndFinishBody));
  }

  void updateNeedShowLostFinishBody({bool needShowLostFinishBody = false}) {
    emit(state.copyWith(needShowLostFinishBody: needShowLostFinishBody));
  }

  void updateGameResultSecondsAmount(int secondsAmount) {
    final gameResult = state.gamesResults[state.gameIndex];

    final updatedGameResult = [...state.gamesResults]
      ..removeAt(state.gameIndex)
      ..insert(
        state.gameIndex,
        gameResult.copyWith(gameSecondsAmount: secondsAmount),
      );

    emit(
      state.copyWith(gamesResults: updatedGameResult),
    );
  }

  void updatePageLoading({bool? needLoading, bool? needFlipAllBack}) {
    if (isClosed) return;

    emit(
      state.copyWith(pageLoading: needLoading ?? !state.pageLoading),
    );

    if (needFlipAllBack ?? false) {
      Future.delayed(const Duration(seconds: 3), _flipBackAll);
    }
  }

  Future<void> updateCardFlipStatus(CardEntity card) async {
    final cardIndex = state.allCards.indexWhere((e) => e.uid == card.uid);
    SoundsAndEffectsService.instance.playTapSound();

    if (cardIndex == -1) return;

    if (card.wasFlipped) {
      SoundsAndEffectsService.instance.smallFeedbackVibration();
    }

    final updatedCards = [...state.allCards]
      ..removeAt(cardIndex)
      ..insert(cardIndex, card);

    emit(state.copyWith(allCards: updatedCards));

    await checkFlippedCards(card);
  }

  void removeCardFromTemporaryFlips(String cardUid) {
    final updateTemporaryFlippedCards = [...state.temporaryFlippedCards]
      ..removeWhere((e) => e.uid == cardUid);

    emit(state.copyWith(temporaryFlippedCards: (updateTemporaryFlippedCards)));
  }

  Future<void> checkFlippedCards(CardEntity card) async {
    final updatedFlippedCards = card.wasFlipped
        ? [...state.temporaryFlippedCards, card]
        : ([...state.temporaryFlippedCards]
          ..removeWhere((e) => card.uid == e.uid));

    emit(state.copyWith(temporaryFlippedCards: updatedFlippedCards));

    if (updatedFlippedCards.length == 2) {
      emit(state.copyWith(canFlipCards: false));

      final firstFlippedCard = updatedFlippedCards.first;
      final lastFlippedCard = updatedFlippedCards.last;

      final firstCardIndex = state.allCards.indexWhere(
        (e) => e.uid == firstFlippedCard.uid,
      );
      final lastCardIndex = state.allCards.indexWhere(
        (e) => e.uid == lastFlippedCard.uid,
      );

      if (firstFlippedCard.imagePath == lastFlippedCard.imagePath) {
        final updatedPassedCards = [...state.passedCards, firstFlippedCard];

        final updateAllCards = [...state.allCards]
          ..removeAt(firstCardIndex)
          ..insert(firstCardIndex, firstFlippedCard.copyWith(canFlip: false))
          ..removeAt(lastCardIndex)
          ..insert(lastCardIndex, lastFlippedCard.copyWith(canFlip: false));

        emit(
          state.copyWith(
            passedCards: updatedPassedCards,
            allCards: updateAllCards,
            temporaryFlippedCards: const [],
            canFlipCards: true,
            needStartTimer: updatedPassedCards.length !=
                state.pairsGame!.pairsGameSettings.gridType.uniqueCards,
          ),
        );

        final cardsAmount =
            state.pairsGame!.pairsGameSettings.gridType.uniqueCards;

        if (updatedPassedCards.length == cardsAmount) {
          Future.delayed(const Duration(seconds: 1), _finishGame);
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 500));

        final updateAllCards = [...state.allCards]
          ..removeAt(firstCardIndex)
          ..insert(firstCardIndex, firstFlippedCard.copyWith(wasFlipped: false))
          ..removeAt(lastCardIndex)
          ..insert(lastCardIndex, lastFlippedCard.copyWith(wasFlipped: false));

        emit(
          state.copyWith(
            allCards: updateAllCards,
            temporaryFlippedCards: const [],
            canFlipCards: true,
          ),
        );
      }
    }
  }

  Future<void> uploadPairsGame(PairsGame pairsGame) async {
    final imagesUrls = await _pairsInteractor.fetchImagesForCategories(
      categories: pairsGame.pairsCategories,
      uniqueImagesAmount: pairsGame.pairsGameSettings.gridType.uniqueCards,
    );

    final expandedImages = Map<PairsCategoryType, List<String>>.unmodifiable(
      {...imagesUrls},
    );

    final allImagesUrls = expandedImages.values.expand((e) => e).toList()
      ..shuffle();

    final allCards = allImagesUrls.map(
      (url) => CardEntity(
        uid: generateUid(),
        imagePath: url,
        wasFlipped: true,
        canFlip: false,
      ),
    );

    if (!isClosed) {
      emit(
        PairsState(
          pairsGame: pairsGame,
          categoriesUniqueImages: expandedImages,
          allCards: allCards.toList(),
          temporaryFlippedCards: const [],
          passedCards: const [],
          gamesResults: [
            GameResult(
              secondsForGame: pairsGame.pairsGameSettings.secondsForGame,
            ),
          ],
        ),
      );
    }
  }

  Future<void> restartGame() async {
    emit(
      state.copyWith(
        pageLoading: true,
        needShowEndFinishBody: false,
        needShowLostFinishBody: false,
        needStartTimer: false,
        currentExperience: null,
        updatedExperience: null,
        needClearExperience: true,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if (isClosed) return;

    final newAllCards = [...state.allCards]
        .map((card) => card.copyWith(wasFlipped: true, canFlip: false))
        .toList()
      ..shuffle();

    emit(
      state.copyWith(
        allCards: newAllCards,
        temporaryFlippedCards: const [],
        passedCards: const [],
        gamesResults: [
          ...state.gamesResults,
          GameResult(
            secondsForGame: state.pairsGame!.pairsGameSettings.secondsForGame,
          ),
        ],
        gameIndex: state.gameIndex + 1,
      ),
    );

    Future.delayed(
      const Duration(seconds: 1),
      () => updatePageLoading(needLoading: false, needFlipAllBack: true),
    );
  }

  void onTimeLeft() {
    if (!state.pairsGame!.pairsGameSettings.timeHardMode) return;

    emit(state.copyWith(canFlipCards: false));

    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (isClosed) return;

        SoundsAndEffectsService.instance.mediumFeedbackVibration();
        SoundsAndEffectsService.instance.playGameFinishSound(soundType: 3);
        updateNeedShowLostFinishBody(needShowLostFinishBody: true);
      },
    );
  }

  void _finishGame() {
    if (isClosed) return;

    final gameResult = state.gamesResults[state.gameIndex];

    final timePercent = 100 -
        ((gameResult.gameSecondsAmount / gameResult.secondsForGame) * 100);

    SoundsAndEffectsService.instance.mediumFeedbackVibration();
    SoundsAndEffectsService.instance.playGameFinishSound(
      soundType:
          state.pairsGame!.pairsGameSettings.needTime && timePercent >= 70
              ? 1
              : 2,
    );

    final experience = _pairsInteractor.calculateNewExperience(
      pairsGame: state.pairsGame!,
      gameResults: state.gamesResults,
    );

    updatePassedGameStatistic();

    emit(
      state.copyWith(
        needShowEndFinishBody: true,
        currentExperience: experience.currentExperience,
        updatedExperience: experience.updatedExperience,
      ),
    );
  }

  void _flipBackAll() {
    if (isClosed) return;

    final updatedCards = [...state.allCards].map(
      (card) => card.copyWith(wasFlipped: false, canFlip: true),
    );

    emit(
      state.copyWith(
        allCards: updatedCards.toList(),
        needStartTimer: true,
        canFlipCards: true,
      ),
    );
  }
}
