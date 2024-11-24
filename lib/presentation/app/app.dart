import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/neuro_pairs_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neuro_pairs/presentation/app/cubit/app_cubit.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/theme/app_theme_provider.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/shared/cubits/locale/locale_cubit.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final availableWidth = context.availableWidth;

    final designSize =
        availableWidth < 600 ? const Size(394, 800) : const Size(800, 394);

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      child: AppThemeProvider(
        appTheme: context.appTheme,
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<AppCubit>(
                create: (_) => Injector.instance.instanceOf<AppCubit>(),
                lazy: false,
              ),
              BlocProvider<LocaleCubit>(
                create: (context) =>
                    Injector.instance.instanceOf<LocaleCubit>(),
                lazy: false,
              ),
            ],
            child: BlocSelector<LocaleCubit, LocaleState, String>(
              selector: (state) => state.currentLocaleName ?? '',
              builder: (context, currentLocaleName) {
                return MaterialApp.router(
                  localizationsDelegates: const [
                    ...AppLocalizations.localizationsDelegates,
                  ],
                  locale: Locale(currentLocaleName),
                  supportedLocales: const [
                    ...AppLocalizations.supportedLocales,
                  ],
                  theme: context.themeData,
                  title: 'NeuroPairs',
                  routerConfig: AppRouter.navigationInstance.config(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
