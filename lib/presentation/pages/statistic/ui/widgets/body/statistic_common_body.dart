import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/logic/statistic_calculator.dart';
import 'package:neuro_pairs/presentation/pages/statistic/cubit/statistic_cubit.dart';
import 'package:neuro_pairs/presentation/pages/statistic/ui/widgets/statistic_circular_chart.dart';
import 'package:neuro_pairs/presentation/pages/statistic/ui/widgets/statistic_counter_block.dart';
import 'package:neuro_pairs/presentation/utils/extensions/int_ext.dart';

final class StatisticCommonBody extends StatelessWidget {
  const StatisticCommonBody({super.key});

  String _gridNameByType(PairsGridType gridType) {
    return switch (gridType) {
      PairsGridType.threeXFour => '3X4',
      PairsGridType.fourXFour => '4X4',
      PairsGridType.fourXFive => '4X5',
      PairsGridType.fourXSix => '4X6',
      PairsGridType.fourXSeven => '4X7',
      PairsGridType.sixXSix => '6X6',
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatisticCubit, StatisticState, SummaryStatistic>(
      selector: (state) => state.summaryStatistic!,
      builder: (context, summaryStatistic) {
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            StatisticCounterBlock(
              countersMap: {
                'Games played': summaryStatistic.summaryGamesAmount.toString(),
                'Time spent': summaryStatistic.summarySecondsInGames
                    .hoursAndMinutesAmount(context),
                'Test': '5543',
              },
            ),
            const SizedBox(height: 32),
            StatisticCircularChart(
              title: 'Games count by grid',
              sectionsMap: Map.fromIterables(
                PairsGridType.values.map(_gridNameByType),
                [12, 4, 3, 1, 5, 6],
              ),
            ),
          ],
        );
      },
    );
  }
}
