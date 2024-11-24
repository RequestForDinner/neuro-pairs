import 'package:neuro_pairs/data/data_sources/interfaces/i_pairs_images_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_preferences_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_remote_auth_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_statistic_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_user_data_source.dart';
import 'package:neuro_pairs/data/repositories/auth/auth_preferences_repository.dart';
import 'package:neuro_pairs/data/repositories/auth/remote_auth_repository.dart';
import 'package:neuro_pairs/data/repositories/pairs/assets_pairs_images_repository.dart';
import 'package:neuro_pairs/data/repositories/pairs/pixabay_pairs_images_repository.dart';
import 'package:neuro_pairs/data/repositories/statistic/remote_statistic_repository.dart';
import 'package:neuro_pairs/data/repositories/user/firestore_user_repository.dart';
import 'package:neuro_pairs/data/repositories/user/settings_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_auth_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/auth/i_remote_auth_repository.dart';
import 'package:neuro_pairs/domain/interfaces/pairs/i_pairs_images_repository.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_user_repository.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';

void injectRepositories() {
  Injector.instance
    ..injectSingleton<IAuthPreferencesRepository>(
      AuthPreferencesRepository(
        Injector.instance.instanceOf<IPreferencesDataSource>(),
      ),
    )
    ..injectSingleton<IRemoteAuthRepository>(
      RemoteAuthRepository(
        Injector.instance.instanceOf<IRemoteAuthDataSource>(),
      ),
    )
    ..injectSingleton<IPairsImagesRepository>(
      PixabayPairsImagesRepository(
        Injector.instance.instanceOf<IPairsImagesDataSource>(
          instanceName: 'pixabay',
        ),
      ),
      instanceName: 'pixabay',
    )
    ..injectSingleton<IPairsImagesRepository>(
      AssetsPairsImagesRepository(
        Injector.instance.instanceOf<IPairsImagesDataSource>(
          instanceName: 'assets',
        ),
      ),
      instanceName: 'assets',
    )
    ..injectSingleton<IUserRepository>(
      FireStoreUserRepository(
        Injector.instance.instanceOf<IUserDataSource>(),
      ),
    )
    ..injectSingleton<IStatisticRepository>(
      RemoteStatisticRepository(
        Injector.instance.instanceOf<IStatisticDataSource>(),
      ),
    )
    ..injectSingleton<ISettingsPreferencesRepository>(
      SettingsPreferencesRepository(
        Injector.instance.instanceOf<IPreferencesDataSource>(),
      ),
    );
}
