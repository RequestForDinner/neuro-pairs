import 'package:neuro_pairs/data/data_sources/interfaces/i_statistic_data_source.dart';
import 'package:neuro_pairs/data/mappers/statistic/experience_mapper.dart';
import 'package:neuro_pairs/data/mappers/statistic/statistic_mapper.dart';
import 'package:neuro_pairs/data/services/firestore_service.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/utils/app_logger.dart';

final class FireStoreStatisticDataSource implements IStatisticDataSource {
  FireStoreService? _fireStoreInstance;
  static const _collectionName = 'statistic';

  @override
  Future<Statistic> createNewStatistic({
    required String userUid,
    required Statistic statistic,
  }) async {
    _initializeFireStoreInstance(userUid);

    try {
      final statisticAlreadyCreated = await _fireStoreInstance!.containsDoc(
        docId: userUid,
      );

      if (!statisticAlreadyCreated) {
        final statisticMapper = StatisticMapper();

        await _fireStoreInstance!.createDoc(
          docId: userUid,
          data: statisticMapper.toJson(statistic),
        );
      } else {
        return fetchStatistic(userUid: userUid);
      }

      return statistic;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Statistic fetching error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  @override
  Future<Statistic> fetchStatistic({required String userUid}) async {
    _initializeFireStoreInstance(userUid);

    try {
      final statisticJson = await _fireStoreInstance!.fetchDoc(docId: userUid);

      if (statisticJson == null) {
        throw Exception('Statistic cannot be empty');
      }

      final statisticMapper = StatisticMapper();

      return statisticMapper.fromJson(statisticJson);
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Statistic fetching error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  @override
  Future<Statistic> updateStatistic({
    required String userUid,
    required Statistic statistic,
  }) async {
    _initializeFireStoreInstance(userUid);

    try {
      final statisticJson = StatisticMapper().toJson(statistic);

      await _fireStoreInstance!.updateDoc(
        docId: userUid,
        data: statisticJson,
      );

      return statistic;
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Statistic updating error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  @override
  Future<void> updatePassedGamesStatistic({
    required String userUid,
    required GameStatisticUnit gameStatisticUnit,
    required Experience experience,
  }) {
    _initializeFireStoreInstance(userUid);

    try {
      final gamesJson = GameStatisticUnitMapper().toJson(gameStatisticUnit);
      final expJson = ExperienceMapper().toJson(experience);

      return _fireStoreInstance!.updateFields(
        docId: userUid,
        fields: [
          FireStoreField(fieldName: 'experience', data: expJson),
          FireStoreField(
            fieldName: 'gamesStatisticUnits',
            isArray: true,
            data: gamesJson,
          ),
        ],
      );
    } on Object catch (e, stackTrace) {
      AppLogger.logError(
        'Statistic updating error',
        error: e,
        stackTrace: stackTrace,
      );

      rethrow;
    }
  }

  void _initializeFireStoreInstance(String userUid) {
    if (_fireStoreInstance != null) return;

    _fireStoreInstance = FireStoreService(_collectionName);
  }
}
