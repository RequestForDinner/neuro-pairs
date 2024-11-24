import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';

abstract interface class IStatisticRepository {
  Stream<Statistic> get statisticStream;

  Statistic? get statistic;

  Future<Statistic> createNewStatistic({
    required String userUid,
    required Statistic statistic,
  });

  Future<Statistic> fetchStatistic({required String userUid});

  Future<Statistic> updateStatistic({
    required String userUid,
    required Statistic statistic,
  });

  Future<void> updatePassedGamesStatistic({
    required String userUid,
    required GameStatisticUnit gameStatisticUnit,
    required Experience experience,
  });
}
