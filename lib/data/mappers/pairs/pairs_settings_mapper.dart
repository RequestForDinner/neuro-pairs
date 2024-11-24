import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';

final class PairsSettingsMapper {
  Map<String, dynamic> toJson(PairsSettings data) {
    return {
      _Fields.gridType: data.gridType.name,
      _Fields.needTime: data.needTime,
      _Fields.timeHardMode: data.timeHardMode,
      _Fields.secondsForGame: data.secondsForGame,
    };
  }

  PairsSettings fromJson(Map<String, dynamic> json) {
    return PairsSettings(
      gridType: PairsGridType.gridTypeFromString(json[_Fields.gridType]),
      needTime: json[_Fields.needTime],
      timeHardMode: json[_Fields.timeHardMode],
      secondsForGame: json[_Fields.secondsForGame],
    );
  }
}

abstract final class _Fields {
  static const gridType = 'gridType';
  static const needTime = 'needTime';
  static const timeHardMode = 'timeHardMode';
  static const secondsForGame = 'secondsForGame';
}
