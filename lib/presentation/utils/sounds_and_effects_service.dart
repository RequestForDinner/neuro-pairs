import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:vibration/vibration.dart';

final class SoundsAndEffectsService {
  static final SoundsAndEffectsService _instance = SoundsAndEffectsService._();

  static SoundsAndEffectsService get instance {
    return _instance;
  }

  SoundsAndEffectsService._();

  static final _player = AudioPlayer();

  bool get _needVibration => Injector.instance
      .instanceOf<ISettingsPreferencesRepository>()
      .fetchVibrationInApp();

  bool get _needSound => Injector.instance
      .instanceOf<ISettingsPreferencesRepository>()
      .fetchSoundInApp();

  Future<void> smallFeedbackVibration() async {
    if (!_needVibration) return;

    if (!(await Vibration.hasVibrator() ?? false)) return;

    HapticFeedback.lightImpact();
  }

  Future<void> mediumFeedbackVibration() async {
    if (!_needVibration) return;

    if (!(await Vibration.hasVibrator() ?? false)) return;

    HapticFeedback.vibrate();
  }

  Future<void> playTapSound() async {
    if (!_needSound) return;

    await _player.stop();
    _player.play(
      AssetSource(AppAssets.tapSound),
      mode: PlayerMode.mediaPlayer,
      volume: 0.1,
    );
  }

  Future<void> playAchievementReceiveSound() async {
    if (!_needSound) return;

    await _player.stop();
    _player.play(
      AssetSource(AppAssets.achievementSound),
      mode: PlayerMode.lowLatency,
      volume: 1,
    );
  }

  Future<void> playGameFinishSound({int soundType = 1}) async {
    if (!_needSound) return;

    final soundAsset = switch (soundType) {
      1 => AppAssets.awesomeGameFinishSound,
      2 => AppAssets.simpleGameFinishSound,
      3 => AppAssets.loseGameFinishSound,
      _ => throw ArgumentError('soundType ($soundType) does not exist'),
    };

    await _player.stop();
    _player.play(
      AssetSource(soundAsset),
      mode: PlayerMode.lowLatency,
      volume: 1,
    );
  }
}
