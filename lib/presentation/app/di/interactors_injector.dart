import 'package:neuro_pairs/domain/interactors/app/app_interactor.dart';
import 'package:neuro_pairs/domain/interactors/auth/auth_interactor.dart';
import 'package:neuro_pairs/domain/interactors/pairs/pairs_interactor.dart';
import 'package:neuro_pairs/domain/interactors/settings/settings_interactor.dart';
import 'package:neuro_pairs/domain/interactors/user/profile_edit_interactor.dart';
import 'package:neuro_pairs/domain/interactors/user/profile_interactor.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_remote_auth_repository.dart';
import 'package:neuro_pairs/domain/interfaces/pairs/i_pairs_images_repository.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';

void injectInteractors() {
  Injector.instance
    ..injectFactory<AppInteractor>(
      () => AppInteractor(
        Injector.instance.instanceOf<IUserRepository>(),
        Injector.instance.instanceOf<IStatisticRepository>(),
        Injector.instance.instanceOf<IAuthPreferencesRepository>(),
        Injector.instance.instanceOf<IRemoteAuthRepository>(),
      ),
    )
    ..injectFactory<AuthInteractor>(
      () => AuthInteractor(
        Injector.instance.instanceOf<IRemoteAuthRepository>(),
        Injector.instance.instanceOf<IAuthPreferencesRepository>(),
        Injector.instance.instanceOf<IUserRepository>(),
        Injector.instance.instanceOf<IStatisticRepository>(),
      ),
    )
    ..injectFactory<PairsInteractor>(
      () => PairsInteractor(
        Injector.instance.instanceOf<IPairsImagesRepository>(
          instanceName: 'pixabay',
        ),
        Injector.instance.instanceOf<IPairsImagesRepository>(
          instanceName: 'assets',
        ),
        Injector.instance.instanceOf<IStatisticRepository>(),
        Injector.instance.instanceOf<IAuthPreferencesRepository>(),
      ),
    )
    ..injectFactory<SettingsInteractor>(
      () => SettingsInteractor(
        Injector.instance.instanceOf<IUserRepository>(),
        Injector.instance.instanceOf<ISettingsPreferencesRepository>(),
      ),
    )
    ..injectFactory<ProfileInteractor>(
      () => ProfileInteractor(
        Injector.instance.instanceOf<IUserRepository>(),
        Injector.instance.instanceOf<IAuthPreferencesRepository>(),
        Injector.instance.instanceOf<IRemoteAuthRepository>(),
        Injector.instance.instanceOf<IStatisticRepository>(),
      ),
    )
    ..injectFactory<ProfileEditInteractor>(
      () => ProfileEditInteractor(
        Injector.instance.instanceOf<IAuthPreferencesRepository>(),
        Injector.instance.instanceOf<IUserRepository>(),
      ),
    );
}
