import 'package:neuro_pairs/data/data_sources/assets_images_data_source.dart';
import 'package:neuro_pairs/data/data_sources/firebase_remote_auth_data_source.dart';
import 'package:neuro_pairs/data/data_sources/firestore_statistic_data_source.dart';
import 'package:neuro_pairs/data/data_sources/firestore_user_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_pairs_images_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_preferences_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_remote_auth_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_statistic_data_source.dart';
import 'package:neuro_pairs/data/data_sources/interfaces/i_user_data_source.dart';
import 'package:neuro_pairs/data/data_sources/pixabay_images_data_source.dart';
import 'package:neuro_pairs/data/data_sources/preferences_data_source.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> injectDataSources() async {
  final preferences = await SharedPreferences.getInstance();

  Injector.instance
    ..injectSingleton<IPreferencesDataSource>(
      PreferencesDataSource(preferences),
    )
    ..injectSingleton<IRemoteAuthDataSource>(
      FirebaseRemoteAuthDataSource(),
    )
    ..injectSingleton<IPairsImagesDataSource>(
      PixabayPairsImagesDataSource(),
      instanceName: 'pixabay',
    )
    ..injectSingleton<IPairsImagesDataSource>(
      AssetsImagesDataSource(),
      instanceName: 'assets',
    )
    ..injectSingleton<IUserDataSource>(
      FireStoreUserDataSource(),
    )
    ..injectSingleton<IStatisticDataSource>(
      FireStoreStatisticDataSource(),
    );
}
