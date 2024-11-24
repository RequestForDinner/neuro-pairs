import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/logic/statistic_calculator.dart';

part 'statistic_state.dart';

class StatisticCubit extends Cubit<StatisticState> {
  final IStatisticRepository _statisticRepository;

  StatisticCubit(this._statisticRepository) : super(StatisticState.init());

  StreamSubscription<Statistic>? _statisticSubscription;

  @override
  Future<void> close() async {
    await _unsubscribeStatistic();

    return super.close();
  }

  void initStatisticPage() {
    _subscribeStatistic();
  }

  Future<void> _unsubscribeStatistic() async {
    await _statisticSubscription?.cancel();
    _statisticSubscription = null;
  }

  Future<void> _subscribeStatistic() async {
    await _unsubscribeStatistic();

    _statisticSubscription = _statisticRepository.statisticStream.listen(
      _onStatisticReceived,
    );
  }

  Future<void> _onStatisticReceived(Statistic statistic) async {
    final statisticCalculator = StatisticCalculator(
      gamesUnits: statistic.gamesStatisticUnits,
    );

    final summaryStatistic =
        await statisticCalculator.calculateSummaryStatistic();

    print(summaryStatistic);

    emit(
      StatisticState(
        statistic: statistic,
        summaryStatistic: summaryStatistic,
      ),
    );
  }
}
