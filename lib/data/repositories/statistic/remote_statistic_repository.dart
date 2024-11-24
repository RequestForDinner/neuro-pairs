import 'package:neuro_pairs/data/data_sources/interfaces/i_statistic_data_source.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:rxdart/rxdart.dart';

final class RemoteStatisticRepository implements IStatisticRepository {
  final IStatisticDataSource _statisticDataSource;

  RemoteStatisticRepository(this._statisticDataSource);

  final _statisticSubject = BehaviorSubject<Statistic>();

  @override
  Stream<Statistic> get statisticStream => _statisticSubject;

  @override
  Statistic? get statistic =>
      _statisticSubject.hasValue ? _statisticSubject.value : null;

  @override
  Future<Statistic> createNewStatistic({
    required String userUid,
    required Statistic statistic,
  }) async {
    final createdStatistic = await _statisticDataSource.createNewStatistic(
      userUid: userUid,
      statistic: statistic,
    );

    _statisticSubject.add(_sortStatistic(createdStatistic));

    return createdStatistic;
  }

  @override
  Future<Statistic> fetchStatistic({required String userUid}) async {
    final fetchedStatistic = await _statisticDataSource.fetchStatistic(
      userUid: userUid,
    );

    _statisticSubject.add(_sortStatistic(fetchedStatistic));

    return fetchedStatistic;
  }

  @override
  Future<Statistic> updateStatistic({
    required String userUid,
    required Statistic statistic,
  }) async {
    final updatedStatistic = await _statisticDataSource.updateStatistic(
      userUid: userUid,
      statistic: statistic,
    );

    _statisticSubject.add(_sortStatistic(updatedStatistic));

    return updatedStatistic;
  }

  @override
  Future<void> updatePassedGamesStatistic({
    required String userUid,
    required GameStatisticUnit gameStatisticUnit,
    required Experience experience,
  }) async {
    if (statistic == null) return;

    await _statisticDataSource.updatePassedGamesStatistic(
      userUid: userUid,
      gameStatisticUnit: gameStatisticUnit,
      experience: experience,
    );

    final updatedStatistic = statistic!.copyWith(
      gamesStatisticUnits: [
        ...statistic!.gamesStatisticUnits,
        gameStatisticUnit
      ],
      experience: experience,
    );

    _statisticSubject.add(_sortStatistic(updatedStatistic));
  }

  Statistic _sortStatistic(Statistic statistic) {
    final gameStatisticUnits = [...statistic.gamesStatisticUnits]..sort(
        (a, b) => a.pairsGame.gameDateTime.compareTo(b.pairsGame.gameDateTime),
      );

    return statistic.copyWith(gamesStatisticUnits: gameStatisticUnits);
  }
}
