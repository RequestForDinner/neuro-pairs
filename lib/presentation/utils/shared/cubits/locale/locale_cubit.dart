import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final ISettingsPreferencesRepository _settingsPreferencesRepository;

  LocaleCubit(this._settingsPreferencesRepository)
      : super(const LocaleState()) {
    _initAppLocale();
  }

  void _initAppLocale() {
    emit(
      state.copyWith(
        currentLocaleName: _settingsPreferencesRepository.fetchLocale(),
      ),
    );
  }

  void changeCurrentLocale(String localeName) {
    _settingsPreferencesRepository.saveLocale(locale: localeName);

    emit(
      state.copyWith(currentLocaleName: localeName),
    );
  }
}
