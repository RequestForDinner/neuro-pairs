import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/domain/entities/pairs/game_result.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/int_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/progress_bar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/user_level.dart';

final class PairsEndFinishBody extends StatefulWidget {
  const PairsEndFinishBody({super.key});

  @override
  State<PairsEndFinishBody> createState() => _PairsEndFinishBodyState();
}

class _PairsEndFinishBodyState extends State<PairsEndFinishBody> {
  @override
  void initState() {
    super.initState();
  }

  void _swapBody(BuildContext context, VoidCallback onSwapFinished) {
    context.read<PairsCubit>()
      ..updateNeedShowEndFinishBody()
      ..updatePassedGameStatistic();

    Future.delayed(const Duration(milliseconds: 300), onSwapFinished);
  }

  String? _winMessage(BuildContext context, double timePercent) {
    return switch (timePercent) {
      >= 70 => context.locale.marvelousWinMessage,
      >= 50 => context.locale.perfectWinMessage,
      > 0 => context.locale.greatWinMessage,
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsCubit, PairsState, (PairsSettings, GameResult)>(
      selector: (state) => (
        state.pairsGame!.pairsGameSettings,
        state.gamesResults[state.gameIndex],
      ),
      builder: (context, params) {
        final gameResult = params.$2;
        final pairsSettings = params.$1;

        final secondsDifference =
            gameResult.secondsForGame - gameResult.gameSecondsAmount;

        final timePercent = 100 -
            ((gameResult.gameSecondsAmount / gameResult.secondsForGame) * 100);

        final winMessage = _winMessage(context, timePercent);

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
          child: SizedBox(
            width: context.availableWidth,
            child: ColoredBox(
              color: Colors.black.withOpacity(0.8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    if (pairsSettings.needTime) ...[
                      if (winMessage != null) ...[
                        Text(
                          winMessage,
                          textAlign: TextAlign.center,
                          style: context.textTheme.headlineLarge?.copyWith(
                            color: context.appTheme.secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                      _TimeCounter(secondsAmount: gameResult.gameSecondsAmount),
                      if (!secondsDifference.isNegative)
                        _TimeSpentMessage(secondsAmount: secondsDifference),
                    ] else
                      Text(
                        context.locale.superWinMessage,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: context.appTheme.secondaryTextColor,
                        ),
                      ),
                    const SizedBox(height: 32),
                    BlocSelector<PairsCubit, PairsState,
                        (Experience?, Experience?)>(
                      selector: (state) => (
                        state.currentExperience,
                        state.updatedExperience,
                      ),
                      builder: (_, params) {
                        final currentExperience = params.$1;
                        final updatedExperience = params.$2;

                        return _ExperienceViewerConfigurator(
                          currentExperience: currentExperience,
                          updatedExperience: updatedExperience,
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    MainButton.text(
                      width: context.availableWidth * 0.7,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.transparent,
                      textStyle: context.textTheme.headlineLarge?.copyWith(
                        color: context.appTheme.contrastTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      buttonText: context.locale.playAgain,
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
                    const SizedBox(height: 32),
                    Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: context.appTheme.secondaryTextColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Завершите игру, чтобы сохранить результаты',
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: context.appTheme.secondaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
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
        ],
      ),
    );
  }
}

final class _ExperienceViewerConfigurator extends StatelessWidget {
  final Experience? currentExperience;
  final Experience? updatedExperience;

  const _ExperienceViewerConfigurator({
    required this.currentExperience,
    required this.updatedExperience,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.fastOutSlowIn,
      switchOutCurve: Curves.fastOutSlowIn,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: updatedExperience == null
          ? const SizedBox()
          : _ExperienceViewer(
              currentExperience: currentExperience!,
              updatedExperience: updatedExperience!,
            ),
    );
  }
}

final class _ExperienceViewer extends StatelessWidget {
  final Experience currentExperience;
  final Experience updatedExperience;

  const _ExperienceViewer({
    required this.currentExperience,
    required this.updatedExperience,
  });

  int _calculateExpDifference() {
    return updatedExperience.currentExperience -
        currentExperience.currentExperience;
  }

  bool _needShowLevelUp() {
    return updatedExperience.currentLevel - currentExperience.currentLevel > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocSelector<PairsCubit, PairsState, int>(
          selector: (state) => state.gameIndex + 1,
          builder: (context, gamesAmount) {
            return Text.rich(
              style: context.textTheme.headlineLarge?.copyWith(
                color: context.appTheme.secondaryTextColor,
              ),
              TextSpan(
                children: [
                  TextSpan(
                    text: 'За ${context.locale.gamesPlural(gamesAmount)} '
                        'получено ',
                  ),
                  TextSpan(
                    text: '+${_calculateExpDifference()} xp.',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.appTheme.activeElementColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            UserLevel(level: updatedExperience.currentLevel),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '(${updatedExperience.currentExperience} '
                                  'xp.)',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.appTheme.contrastTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${updatedExperience.nextLevelExperience} xp.',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.appTheme.contrastTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ProgressBar(
                          endProgressValue:
                              updatedExperience.nextLevelExperience,
                          startProgressValue:
                              updatedExperience.startCurrentLevelExperience,
                          currentProgressValue:
                              updatedExperience.currentExperience,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        if (_needShowLevelUp()) ...[
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.levelUp,
                width: 30.r,
                height: 36.r,
                colorFilter: ColorFilter.mode(
                  context.appTheme.activeElementColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Уровень увеличен!',
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.appTheme.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ],
    );
  }
}
