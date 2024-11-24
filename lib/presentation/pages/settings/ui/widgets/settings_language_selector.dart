import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/pages/settings/ui/utils/locale_asset.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/shared/cubits/locale/locale_cubit.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/selector_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_child_dialog.dart';

final class SettingsLanguageSelector extends StatelessWidget {
  final ValueChanged<String> onLocaleChanged;

  const SettingsLanguageSelector({required this.onLocaleChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return AppChildDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.language,
                width: 36,
                height: 36,
                colorFilter: ColorFilter.mode(
                  context.appTheme.primaryIconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Select language',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 32),
          BlocSelector<LocaleCubit, LocaleState, String>(
            selector: (state) => state.currentLocaleName ?? '',
            builder: (context, currentLocaleName) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: context.availableHeight * 0.35,
                ),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    SelectorButton(
                      onSelected: onLocaleChanged,
                      title: 'Deutsch',
                      unique: 'de',
                      selectedValue: currentLocaleName,
                      imagePath: LocaleAsset.localeAssetFromLocalName('de'),
                    ),
                    SelectorButton(
                      onSelected: onLocaleChanged,
                      title: 'Engilsh',
                      unique: 'en',
                      selectedValue: currentLocaleName,
                      imagePath: LocaleAsset.localeAssetFromLocalName('en'),
                    ),
                    SelectorButton(
                      onSelected: onLocaleChanged,
                      title: 'Español',
                      unique: 'es',
                      selectedValue: currentLocaleName,
                      imagePath: LocaleAsset.localeAssetFromLocalName('es'),
                    ),
                    SelectorButton(
                      onSelected: onLocaleChanged,
                      title: 'हिंदी',
                      unique: 'hi',
                      selectedValue: currentLocaleName,
                      imagePath: LocaleAsset.localeAssetFromLocalName('hi'),
                    ),
                    SelectorButton(
                      onSelected: onLocaleChanged,
                      title: '中國人',
                      unique: 'zh',
                      selectedValue: currentLocaleName,
                      imagePath: LocaleAsset.localeAssetFromLocalName('zh'),
                    ),
                    SelectorButton(
                      onSelected: onLocaleChanged,
                      title: 'Русский',
                      unique: 'ru',
                      selectedValue: currentLocaleName,
                      imagePath: LocaleAsset.localeAssetFromLocalName('ru'),
                    ),
                  ].insertBetween(
                    const SizedBox(height: 8),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
