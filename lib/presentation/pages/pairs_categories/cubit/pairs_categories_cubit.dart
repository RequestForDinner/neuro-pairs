import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:neuro_pairs/domain/utils/internet_status_checker.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';

part 'pairs_categories_state.dart';

class PairsCategoriesCubit extends Cubit<PairsCategoriesState> {
  PairsCategoriesCubit() : super(PairsCategoriesState.init());

  Future<void> init(PairsSettings? pairsSettings) async {
    if (pairsSettings == null) {
      AppRouter.navigationInstance.replace(const PairsSettingsRoute());
      return;
    }

    emit(
      PairsCategoriesState(pairsSettings: pairsSettings),
    );

    final canSelectOnlineCategories =
        await InternetStatusChecker.checkInternetStatus();

    if (!isClosed) {
      emit(
        state.copyWith(canSelectOnlineCategories: canSelectOnlineCategories),
      );
    }
  }

  void navigateToPairsGame() {
    AppRouter.navigationInstance.push(
      PairsRoute(
        pairsGame: PairsGame(
          gameDateTime: DateTime.now(),
          pairsGameSettings: state.pairsSettings,
          pairsCategories: state.categoriesTypes,
        ),
      ),
    );
  }

  Future<void> updateInternetStatus() async {
    final canSelectOnlineCategories =
        await InternetStatusChecker.checkInternetStatus();

    if (!isClosed) {
      emit(
        state.copyWith(canSelectOnlineCategories: canSelectOnlineCategories),
      );
    }
  }

  void updateSelectedCategories(PairsCategoryType categoryType) {
    final currentGridType = state.pairsSettings.gridType;
    final currentCategories = [...state.categoriesTypes];

    if (currentCategories.contains(categoryType)) {
      currentCategories.removeWhere((e) => e == categoryType);
    } else {
      currentCategories.add(categoryType);
    }

    final selectedCategoriesCount = currentCategories.length;

    emit(
      state.copyWith(
        canAddNewCategory:
            selectedCategoriesCount < currentGridType.uniqueCards,
        categoriesTypes: currentCategories,
      ),
    );
  }
}
