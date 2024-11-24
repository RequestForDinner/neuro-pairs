import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/pairs_grid.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/pairs_progress_bar.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/pairs_timer.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/vector_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_info_dialog.dart';

final class PairsBody extends StatelessWidget {
  final VoidCallback onImagesLoaded;

  const PairsBody({
    required this.onImagesLoaded,
    super.key,
  });

  Future<void> _showExitDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AppInfoDialog(
          title:
              'Если вы покините игру, прогресс не сохранится, а статистика не будет записана.\n\nВы уверены, что хотите покинуть игру?',
          primaryText: context.locale.yes,
          secondaryText: context.locale.no,
          onPrimaryTap: () => AppRouter.navigationInstance.replaceAll(
            const [MainRoute()],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsCubit, PairsState, PairsSettings?>(
      selector: (state) => state.pairsGame?.pairsGameSettings,
      builder: (context, pairsSettings) {
        if (pairsSettings == null) return const SizedBox();

        return Column(
          children: [
            SizedBox(height: context.viewPaddingOf.top + 16),
            Row(
              children: [
                if (pairsSettings.needTime) ...[
                  const SizedBox(width: 8),
                  BlocSelector<PairsCubit, PairsState, int>(
                    selector: (state) => state.gameIndex,
                    builder: (context, gamesAmount) {
                      return PairsTimer(
                        key: ValueKey<int>(gamesAmount),
                        onTimeReceive: (secondsAmount) => context
                            .read<PairsCubit>()
                            .updateGameResultSecondsAmount(secondsAmount),
                        duration: Duration(
                          seconds: pairsSettings.secondsForGame,
                        ),
                        onTimeEnd: context.read<PairsCubit>().onTimeLeft,
                      );
                    },
                  ),
                ],
                const Spacer(),
                VectorButton.iconData(
                  onTap: () => _showExitDialog(context),
                  iconData: Icons.close,
                  innerPadding: const EdgeInsets.all(4),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BlocSelector<PairsCubit, PairsState, int>(
                selector: (state) => state.passedCards.length,
                builder: (context, currentProgress) {
                  return PairsProgressBar(
                    maxProgress: pairsSettings.gridType.uniqueCards,
                    currentProgress: currentProgress,
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: PairsGrid(
                pairsGridType: pairsSettings.gridType,
                onLoadingFinished: onImagesLoaded,
              ),
            ),
            SizedBox(height: context.viewPaddingOf.bottom + 8),
          ],
        );
      },
    );
  }
}
