import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/cubit/pairs_settings_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/app_switch.dart';

final class PairsTimeSelectors extends StatefulWidget {
  const PairsTimeSelectors({super.key});

  @override
  State<PairsTimeSelectors> createState() => _PairsTimeSelectorsState();
}

class _PairsTimeSelectorsState extends State<PairsTimeSelectors>
    with SingleTickerProviderStateMixin {
  late final AnimationController _timeSelectorsBlurController;

  @override
  void initState() {
    super.initState();

    _timeSelectorsBlurController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  void _updateNeedTime(BuildContext context, bool needTime) {
    context.read<PairsSettingsCubit>().updatePairsSettings(needTime: needTime);

    needTime
        ? _timeSelectorsBlurController.reverse()
        : _timeSelectorsBlurController.forward();
  }

  void _updateHardMode(BuildContext context, bool hardMode) {
    context.read<PairsSettingsCubit>().updatePairsSettings(
          timeHardMode: hardMode,
        );
  }

  @override
  void dispose() {
    _timeSelectorsBlurController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsSettingsCubit, PairsSettingsState, bool>(
      selector: (state) => state.pairsSettings.needTime,
      builder: (context, needTime) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('With time', style: context.textTheme.headlineMedium),
                const SizedBox(width: 8),
                Tooltip(
                  message: 'You can turn off time tracking and play for fun, '
                      'however, in this case some achievements will '
                      'not be available to you.',
                  triggerMode: TooltipTriggerMode.tap,
                  textStyle: context.textTheme.headlineSmall,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  showDuration: const Duration(seconds: 5),
                  child: Icon(
                    Icons.info_outline,
                    size: 24.r,
                    color: context.appTheme.activeElementColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: needTime,
              onValueChanged: (needTime) => _updateNeedTime(context, needTime),
            ),
            const SizedBox(height: 32),
            IgnorePointer(
              ignoring: !needTime,
              child: AnimatedBuilder(
                animation: CurvedAnimation(
                  parent: _timeSelectorsBlurController,
                  curve: Curves.decelerate,
                ),
                builder: (_, child) {
                  final value = _timeSelectorsBlurController.value * 10;

                  return ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaY: value, sigmaX: value),
                    child: child,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hard mode',
                          style: context.textTheme.headlineMedium,
                        ),
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'If “Hard mode” is enabled, the game '
                              'will be forced to end after the set time has '
                              'elapsed.',
                          triggerMode: TooltipTriggerMode.tap,
                          textStyle: context.textTheme.headlineSmall,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          showDuration: const Duration(seconds: 5),
                          child: Icon(
                            Icons.info_outline,
                            size: 24.r,
                            color: context.appTheme.activeElementColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    BlocSelector<PairsSettingsCubit, PairsSettingsState, bool>(
                      selector: (state) => state.pairsSettings.timeHardMode,
                      builder: (context, timeHardMode) {
                        return AppSwitch(
                          value: timeHardMode,
                          onValueChanged: (timeHardMode) => _updateHardMode(
                            context,
                            timeHardMode,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Time for game',
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    const _PairsTimeSelector(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

final class _PairsTimeSelector extends StatefulWidget {
  const _PairsTimeSelector();

  @override
  State<_PairsTimeSelector> createState() => _PairsTimeSelectorState();
}

class _PairsTimeSelectorState extends State<_PairsTimeSelector> {
  late ValueKey _key;

  @override
  void initState() {
    super.initState();

    _key = const ValueKey<int>(70);
  }

  int _minSecondsForGridType(PairsGridType gridType) {
    return switch (gridType) {
      PairsGridType.threeXFour => 10,
      PairsGridType.fourXFour => 15,
      PairsGridType.fourXFive => 20,
      PairsGridType.fourXSix => 40,
      PairsGridType.fourXSeven => 50,
      PairsGridType.sixXSix => 60,
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

  int _averageSecondsForGridType(PairsGridType gridType) {
    return switch (gridType) {
      PairsGridType.threeXFour => 40,
      PairsGridType.fourXFour => 70,
      PairsGridType.fourXFive => 110,
      PairsGridType.fourXSix => 140,
      PairsGridType.fourXSeven => 170,
      PairsGridType.sixXSix => 200,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PairsSettingsCubit, PairsSettingsState>(
      listener: (context, state) {
        _key = ValueKey(state.pairsSettings.secondsForGame);
        context.read<PairsSettingsCubit>().updatePairsSettings(
              secondsForGame: _averageSecondsForGridType(
                state.pairsSettings.gridType,
              ),
            );
      },
      listenWhen: (prev, curr) =>
          prev.pairsSettings.gridType != curr.pairsSettings.gridType,
      child: BlocSelector<PairsSettingsCubit, PairsSettingsState,
          (int, PairsGridType)>(
        selector: (state) => (
          state.pairsSettings.secondsForGame,
          state.pairsSettings.gridType,
        ),
        builder: (context, params) {
          final secondsForGame = params.$1;
          final gridType = params.$2;

          final minutesForGame = (secondsForGame / 60).floor();

          return Row(
            children: [
              Expanded(
                child: InteractiveSlider(
                  key: _key,
                  min: _minSecondsForGridType(gridType).toDouble(),
                  initialProgress: 0.4,
                  unfocusedOpacity: 0.8,
                  max: _maxSecondsForGridType(gridType).toDouble(),
                  unfocusedHeight: 20,
                  focusedHeight: 40,
                  unfocusedMargin: EdgeInsets.zero,
                  backgroundColor: Colors.white,
                  foregroundColor: context.appTheme.activeElementColor,
                  padding: EdgeInsets.zero,
                  onChanged: (value) {
                    final minutes = value ~/ 60;
                    final seconds = value ~/ 10 * 10;

                    context.read<PairsSettingsCubit>().updatePairsSettings(
                          secondsForGame: minutes < 1 ? seconds : minutes * 60,
                        );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  Text(
                    minutesForGame < 1
                        ? '$secondsForGame '
                        : '$minutesForGame ',
                    style: context.textTheme.headlineLarge?.copyWith(
                      color: context.appTheme.activeElementColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    minutesForGame < 1 ? 'sec' : 'min',
                    style: context.textTheme.headlineMedium,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
