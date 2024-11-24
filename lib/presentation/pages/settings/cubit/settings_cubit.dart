import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interactors/settings/settings_interactor.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsInteractor _settingsInteractor;

  SettingsCubit(this._settingsInteractor) : super(const SettingsState()) {
    _initPage();
  }

  StreamSubscription<User?>? _userSubscription;

  @override
  Future<void> close() async {
    await _unsubscribeUserStream();

    return super.close();
  }

  void updateSoundsInApp({required bool soundsInApp}) {
    _settingsInteractor.saveSoundsInApp(soundsInApp: soundsInApp);

    emit(
      state.copyWith(soundsInApp: soundsInApp),
    );
  }

  void updateVibrationInApp({required bool vibrationInApp}) {
    _settingsInteractor.saveVibrationInApp(vibrationInApp: vibrationInApp);

    emit(
      state.copyWith(vibrationInApp: vibrationInApp),
    );
  }

  void updateCurrentLocale({required String localeName}) {
    _settingsInteractor.saveLocale(localeName: localeName);
  }

  Future<void> _initPage() async {
    emit(
      state.copyWith(
        soundsInApp: _settingsInteractor.needSoundInApp,
        vibrationInApp: _settingsInteractor.needVibrationInApp,
      ),
    );

    await _subscribeUserStream();
  }

  Future<void> _subscribeUserStream() async {
    await _unsubscribeUserStream();

    _userSubscription = _settingsInteractor.userStream.listen(_onNewUser);
  }

  Future<void> _unsubscribeUserStream() async {
    await _userSubscription?.cancel();
    _userSubscription = null;
  }

  void _onNewUser(User? user) {
    emit(
      state.copyWith(user: user, shouldClearUser: true),
    );
  }
}
