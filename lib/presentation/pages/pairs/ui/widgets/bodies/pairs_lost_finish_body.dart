import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/int_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class PairsLostFinishBody extends StatefulWidget {
  const PairsLostFinishBody({super.key});

  @override
  State<PairsLostFinishBody> createState() => _PairsLostFinishBodyState();
}

class _PairsLostFinishBodyState extends State<PairsLostFinishBody> {
  void _swapBody(BuildContext context, VoidCallback onSwapFinished) {
    context.read<PairsCubit>()
      ..updateNeedShowLostFinishBody()
      ..updatePassedGameStatistic();

    Future.delayed(const Duration(milliseconds: 300), onSwapFinished);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsCubit, PairsState, GameResult>(
      selector: (state) => state.gamesResults[state.gameIndex],
      builder: (context, gameResult) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
          child: SizedBox(
            width: context.availableWidth,
            child: ColoredBox(
              color: Colors.black.withOpacity(0.7),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.locale.lostGameMessage,
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineLarge?.copyWith(
                        color: context.appTheme.contrastTextColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    MainButton.text(
                      width: context.availableWidth * 0.7,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      textStyle: context.textTheme.headlineLarge?.copyWith(
                        color: context.appTheme.activeElementColor,
                        fontWeight: FontWeight.bold,
                      ),
                      buttonText: context.locale.tryAgain,
                      onTap: context.read<PairsCubit>().restartGame,
                    ),
                    const SizedBox(height: 16),
                    MainButton.text(
                      width: context.availableWidth * 0.7,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      textStyle: context.textTheme.headlineLarge?.copyWith(
                        color: context.appTheme.contrastTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      buttonText: 'New game',
                      onTap: () => _swapBody(
                        context,
                        () => AppRouter.navigationInstance
                          ..replaceAll(const [MainRoute()])
                          ..push(const PairsSettingsRoute()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    MainButton.text(
                      width: context.availableWidth * 0.7,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: context.textTheme.headlineLarge?.copyWith(
                        color: context.appTheme.contrastTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      backgroundColor: Colors.transparent,
                      buttonText: 'Main menu',
                      onTap: () => _swapBody(
                        context,
                        () => AppRouter.navigationInstance.replaceAll(
                          const [MainRoute()],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

final class _TimeSpentMessage extends StatelessWidget {
  final int secondsAmount;

  const _TimeSpentMessage({required this.secondsAmount});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.textTheme.headlineLarge?.copyWith(
          color: context.appTheme.secondaryTextColor,
        ),
        children: [
          TextSpan(
            text: context.locale.spentSecondsDifferenceFirstPart,
          ),
          TextSpan(
            text: '${context.locale.minutesAmountPartly(
              secondsAmount.minutesAmount(),
            )} ',
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appTheme.contrastTextColor,
            ),
          ),
          TextSpan(
            text: context.locale.secondsAmountPartly(
              secondsAmount.secondsAmount(),
            ),
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appTheme.activeElementColor,
            ),
          ),
          TextSpan(
            text: context.locale.spentSecondsDifferenceSecondPart,
          ),
        ],
      ),
    );
  }
}

final class _TimeCounter extends StatelessWidget {
  final int secondsAmount;

  const _TimeCounter({required this.secondsAmount});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: context.locale.completedIn,
            style: context.textTheme.headlineLarge?.copyWith(
              color: context.appTheme.secondaryTextColor,
            ),
          ),
          TextSpan(
            text: '${secondsAmount.minutesAmount()} min ',
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appTheme.contrastTextColor,
            ),
          ),
          TextSpan(
            text: '${secondsAmount.secondsAmount()} sec',
            style: context.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.appTheme.activeElementColor,
            ),
          ),
        ],
      ),
    );
  }
}
