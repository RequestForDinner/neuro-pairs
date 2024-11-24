import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/main/ui/widgets/main_menu_buttons_block.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/horizontal_insets.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_info_dialog.dart';

final class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  Future<void> _onPopScope(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AppInfoDialog(
          title: context.locale.exitMessage,
          onPrimaryTap: SystemNavigator.pop,
          primaryText: context.locale.yes,
          secondaryText: context.locale.affirmativelyNo,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _onPopScope(context),
      child: Stack(
        children: [
          const _BackgroundImage(),
          HorizontalInsets(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.viewPaddingOf.top + 50),
                const _AppTitle(),
                const SizedBox(height: 32),
                const Spacer(),
                MainMenuButtonsBlock(
                  onPlayTap: () {
                    SoundsAndEffectsService.instance.playTapSound();
                    AppRouter.navigationInstance.push(
                      const PairsSettingsRoute(),
                    );
                  },
                  onProfileTap: () {
                    SoundsAndEffectsService.instance.playTapSound();
                    AppRouter.navigationInstance.push(
                      const ProfileRoute(),
                    );
                  },
                  onSettingsTap: () {
                    SoundsAndEffectsService.instance.playTapSound();
                    AppRouter.navigationInstance.push(
                      const SettingsRoute(),
                    );
                  },
                ),
                const Spacer(),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: context.locale.providedBy,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.appTheme.contrastTextColor,
                          ),
                        ),
                        TextSpan(
                          text: 'requestfordinner',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.appTheme.activeElementColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: context.viewPaddingOf.bottom + 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _AppTitle extends StatelessWidget {
  const _AppTitle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Neuro',
              style: context.textTheme.titleLarge?.copyWith(
                letterSpacing: 10,
                fontSize: 30.sp,
                color: context.appTheme.contrastTextColor,
              ),
            ),
            TextSpan(
              text: 'Pairs',
              style: context.textTheme.titleLarge?.copyWith(
                fontSize: 30.sp,
                color: context.appTheme.activeElementColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child: Image.asset(
              'assets/raw/main_menu_background_image.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned.fill(
          child: ColoredBox(color: Colors.black54),
        ),
      ],
    );
  }
}
