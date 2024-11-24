import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile/ui/widgets/profile_games_week_chart.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/int_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class ProfileStatisticBlock extends StatelessWidget {
  const ProfileStatisticBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                context.locale.statistic,
                style: context.textTheme.titleSmall,
              ),
              const Spacer(),
              MainButton.text(
                onTap: () => AppRouter.navigationInstance.push(
                  const StatisticRoute(),
                ),
                buttonText: context.locale.showAll,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8),
                textStyle: context.textTheme.headlineSmall?.copyWith(
                  color: context.appTheme.activeElementColor,
                ),
              ),
            ],
          ),
          Text(
            context.locale.lastWeek,
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.appTheme.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 8),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.appTheme.nonActiveElementColor,
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: BlocSelector<ProfileCubit, ProfileState, (int, int)>(
                selector: (state) => (
                  state.summaryGamesAmount,
                  state.summarySecondsInGame,
                ),
                builder: (context, params) {
                  final summaryGamesAmount = params.$1;
                  final summarySecondsInGame = params.$2;

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 16),
                          _InfoBlock(
                            title: context.locale.gamesAmount,
                            value: '$summaryGamesAmount',
                          ),
                          _InfoBlock(
                            title: context.locale.timeInGame,
                            value: summarySecondsInGame.hoursAndMinutesAmount(
                              context,
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                      Divider(
                        color: context.appTheme.mainBackground,
                        height: 32,
                        indent: 16,
                        endIndent: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: BlocSelector<ProfileCubit, ProfileState,
                                List<MapEntry<int, int>>>(
                              selector: (state) => state.lastWeekGamesAmount,
                              builder: (context, lastWeekGamesAmount) {
                                return ProfileGamesWeekChart(
                                  chartData: lastWeekGamesAmount,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _InfoBlock extends StatelessWidget {
  final String title;
  final String value;

  const _InfoBlock({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.appTheme.secondaryTextColor,
          ),
        ),
        Text(
          value,
          style: context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
