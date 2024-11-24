part of 'pairs_settings_cubit.dart';

final class PairsSettingsState {
  final PairsSettings pairsSettings;

  const PairsSettingsState({
    required this.pairsSettings,
  });

  factory PairsSettingsState.init() => PairsSettingsState(
        pairsSettings: PairsSettings.defaultSettings(),
      );

  PairsSettingsState copyWith({
    PairsSettings? pairsSettings,
  }) {
    return PairsSettingsState(
      pairsSettings: pairsSettings ?? this.pairsSettings,
    );
  }
}
