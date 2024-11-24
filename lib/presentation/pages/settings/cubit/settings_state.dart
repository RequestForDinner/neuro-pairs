part of 'settings_cubit.dart';

final class SettingsState {
  final User? user;

  final bool soundsInApp;
  final bool vibrationInApp;

  const SettingsState({
    this.soundsInApp = true,
    this.vibrationInApp = true,
    this.user,
  });

  SettingsState copyWith({
    User? user,
    bool? soundsInApp,
    bool? vibrationInApp,
    bool shouldClearUser = false,
  }) {
    return SettingsState(
      user: shouldClearUser ? user : user ?? this.user,
      soundsInApp: soundsInApp ?? this.soundsInApp,
      vibrationInApp: vibrationInApp ?? this.vibrationInApp,
    );
  }
}
