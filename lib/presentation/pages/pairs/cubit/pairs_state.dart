part of 'pairs_cubit.dart';

final class PairsState {
  final PairsGame? pairsGame;

  final Experience? currentExperience;
  final Experience? updatedExperience;

  final Map<PairsCategoryType, List<String>> categoriesUniqueImages;
  final List<CardEntity> allCards;

  final List<CardEntity> temporaryFlippedCards;
  final List<CardEntity> passedCards;

  final List<GameResult> gamesResults;

  final bool pageLoading;
  final bool canFlipCards;
  final bool needStartTimer;
  final bool needShowEndFinishBody;
  final bool needShowLostFinishBody;

  final int gameIndex;

  const PairsState({
    required this.categoriesUniqueImages,
    required this.temporaryFlippedCards,
    required this.passedCards,
    required this.allCards,
    required this.gamesResults,
    this.pairsGame,
    this.currentExperience,
    this.updatedExperience,
    this.pageLoading = true,
    this.canFlipCards = true,
    this.needStartTimer = false,
    this.needShowEndFinishBody = false,
    this.needShowLostFinishBody = false,
    this.gameIndex = 0,
  });

  factory PairsState.init() => const PairsState(
        categoriesUniqueImages: {},
        temporaryFlippedCards: [],
        passedCards: [],
        gamesResults: [],
        allCards: [],
      );

  PairsState copyWith({
    Experience? currentExperience,
    Experience? updatedExperience,
    bool? pageLoading,
    bool? canFlipCards,
    List<CardEntity>? allCards,
    List<CardEntity>? temporaryFlippedCards,
    List<CardEntity>? passedCards,
    List<GameResult>? gamesResults,
    bool? needStartTimer,
    bool? needShowEndFinishBody,
    bool? needShowLostFinishBody,
    int? gameIndex,
    bool needClearExperience = false,
  }) {
    return PairsState(
      pairsGame: pairsGame,
      currentExperience: needClearExperience
          ? null
          : currentExperience ?? this.currentExperience,
      updatedExperience: needClearExperience
          ? null
          : updatedExperience ?? this.updatedExperience,
      categoriesUniqueImages: categoriesUniqueImages,
      temporaryFlippedCards:
          temporaryFlippedCards ?? this.temporaryFlippedCards,
      passedCards: passedCards ?? this.passedCards,
      allCards: allCards ?? this.allCards,
      gamesResults: gamesResults ?? this.gamesResults,
      pageLoading: pageLoading ?? this.pageLoading,
      canFlipCards: canFlipCards ?? this.canFlipCards,
      needStartTimer: needStartTimer ?? this.needStartTimer,
      needShowEndFinishBody:
          needShowEndFinishBody ?? this.needShowEndFinishBody,
      needShowLostFinishBody:
          needShowLostFinishBody ?? this.needShowLostFinishBody,
      gameIndex: gameIndex ?? this.gameIndex,
    );
  }
}
