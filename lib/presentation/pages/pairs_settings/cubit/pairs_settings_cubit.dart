import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';

part 'pairs_settings_state.dart';

class PairsSettingsCubit extends Cubit<PairsSettingsState> {
  PairsSettingsCubit() : super(PairsSettingsState.init());

  void navigateToPairsCategories() {
    AppRouter.navigationInstance.push(
      PairsCategoriesRoute(pairsSettings: state.pairsSettings),
    );
  }

  void updatePairsSettings({
    PairsGridType? gridType,
    bool? needTime,
    bool? timeHardMode,
    int? secondsForGame,
  }) {
    final updatedPairsSettings = state.pairsSettings.copyWith(
      gridType: gridType,
      needTime: needTime,
      timeHardMode: timeHardMode,
      secondsForGame: secondsForGame,
    );

    emit(
      state.copyWith(pairsSettings: updatedPairsSettings),
    );
  }
}
