import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:neuro_pairs/presentation/pages/settings/ui/widgets/settings_button.dart';
import 'package:neuro_pairs/presentation/pages/settings/ui/widgets/settings_language_selector.dart';
import 'package:neuro_pairs/presentation/pages/settings/ui/widgets/settings_sounds_selector.dart';
import 'package:neuro_pairs/presentation/pages/settings/ui/widgets/settings_user_button.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/shared/cubits/locale/locale_cubit.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/transitioned_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/app_bar/custom_app_bar.dart';

final class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  var _needLoading = false;

  Future<void> _showSoundsAndEffectsSelectorDialog(BuildContext context) {
    return showCupertinoDialog(
      barrierDismissible: true,
      useRootNavigator: true,
      context: context,
      builder: (_) {
        return BlocSelector<SettingsCubit, SettingsState, (bool, bool)>(
          bloc: context.read<SettingsCubit>(),
          selector: (state) => (state.soundsInApp, state.vibrationInApp),
          builder: (_, params) {
            final soundsInApp = params.$1;
            final vibrationInApp = params.$2;

            return SettingsSoundsSelector(
              soundsInApp: soundsInApp,
              vibrationInApp: vibrationInApp,
              onSoundsChanged: (value) {
                context.read<SettingsCubit>().updateSoundsInApp(
                      soundsInApp: value,
                    );
              },
              onEffectsChanged: (value) {
                context.read<SettingsCubit>().updateVibrationInApp(
                      vibrationInApp: value,
                    );
              },
            );
          },
        );
      },
    );
  }

  Future<void> _showLanguageSelectorDialog(BuildContext context) {
    return showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (_) {
        return SettingsLanguageSelector(
          onLocaleChanged: (locale) {
            context.read<LocaleCubit>().changeCurrentLocale(locale);
            _startAndFinishLoading();
          },
        );
      },
    );
  }

  void _startAndFinishLoading() {
    setState(() => _needLoading = true);

    Future.delayed(
      const Duration(milliseconds: 600),
      () => setState(() => _needLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _needLoading
          ? null
          : TransitionedBody(
              child: Column(
                children: [
                  CustomAppBar(
                    titleText: context.locale.settings,
                    onLeadingTap: AppRouter.navigationInstance.maybePop,
                    leadingIcon: Icons.arrow_back_ios_new,
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          const SettingsUserButton(),
                          const SizedBox(),
                          SettingsButton(
                            onTap: () => _showSoundsAndEffectsSelectorDialog(
                              context,
                            ),
                            svgPath: AppAssets.sounds,
                            text: context.locale.soundsAndEffects,
                          ),
                          SettingsButton(
                            onTap: () => _showLanguageSelectorDialog(context),
                            svgPath: AppAssets.language,
                            text: context.locale.language,
                          ),
                          SettingsButton(
                            svgPath: AppAssets.privacyPolicy,
                            text: context.locale.privacyPolicy,
                          ),
                          SettingsButton(
                            svgPath: AppAssets.terms,
                            text: context.locale.termsOfUse,
                          ),
                          SettingsButton(
                            svgPath: AppAssets.infoIcon,
                            text: context.locale.aboutApp,
                          ),
                        ].insertBetween(const SizedBox(height: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
