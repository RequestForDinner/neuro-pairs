import 'package:neuro_pairs/domain/interactors/app/app_interactor.dart';
import 'package:neuro_pairs/domain/interactors/auth/auth_interactor.dart';
import 'package:neuro_pairs/domain/interactors/pairs/pairs_interactor.dart';
import 'package:neuro_pairs/domain/interactors/settings/settings_interactor.dart';
import 'package:neuro_pairs/domain/interactors/user/profile_edit_interactor.dart';
import 'package:neuro_pairs/domain/interactors/user/profile_interactor.dart';
import 'package:neuro_pairs/domain/interfaces/statistic/i_statistic_repository.dart';
import 'package:neuro_pairs/domain/interfaces/user/i_settings_preferences_repository.dart';
import 'package:neuro_pairs/platform/interfaces/i_image_picker_client.dart';
import 'package:neuro_pairs/presentation/app/cubit/app_cubit.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/auth/cubit/auth_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs_categories/cubit/pairs_categories_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/cubit/pairs_settings_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'package:neuro_pairs/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:neuro_pairs/presentation/pages/statistic/cubit/statistic_cubit.dart';
import 'package:neuro_pairs/presentation/utils/shared/cubits/locale/locale_cubit.dart';

void injectCubits() {
  Injector.instance
    ..injectFactory<AppCubit>(
      () => AppCubit(Injector.instance.instanceOf<AppInteractor>()),
    )
    ..injectFactory<AuthCubit>(
      () => AuthCubit(Injector.instance.instanceOf<AuthInteractor>()),
    )
    ..injectFactory<PairsSettingsCubit>(
      () => PairsSettingsCubit(),
    )
    ..injectFactory<PairsCategoriesCubit>(
      () => PairsCategoriesCubit(),
    )
    ..injectFactory<PairsCubit>(
      () => PairsCubit(
        Injector.instance.instanceOf<PairsInteractor>(),
      ),
    )
    ..injectFactory<SettingsCubit>(
      () => SettingsCubit(Injector.instance.instanceOf<SettingsInteractor>()),
    )
    ..injectFactory<LocaleCubit>(
      () => LocaleCubit(
        Injector.instance.instanceOf<ISettingsPreferencesRepository>(),
      ),
    )
    ..injectFactory<ProfileCubit>(
      () => ProfileCubit(Injector.instance.instanceOf<ProfileInteractor>()),
    )
    ..injectFactory<ProfileEditCubit>(
      () => ProfileEditCubit(
        Injector.instance.instanceOf<ProfileEditInteractor>(),
        Injector.instance.instanceOf<IImagePickerClient>(),
      ),
    )
    ..injectFactory<StatisticCubit>(
      () => StatisticCubit(
        Injector.instance.instanceOf<IStatisticRepository>(),
      ),
    );
}
