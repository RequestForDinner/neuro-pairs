part of 'statistic_cubit.dart';

final class StatisticState {
  final Statistic statistic;

  final SummaryStatistic? summaryStatistic;

  const StatisticState({
    required this.statistic,
    required this.summaryStatistic,
  });

  factory StatisticState.init() => StatisticState(
        statistic: Statistic.empty(),
        summaryStatistic: null,
      );

  StatisticState copyWith() {
    return StatisticState(
      statistic: statistic,
      summaryStatistic: summaryStatistic,
    );
  }
}
