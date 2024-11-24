import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class MainMenuButtonsBlock extends StatelessWidget {
  final VoidCallback onPlayTap;
  final VoidCallback onProfileTap;
  final VoidCallback onSettingsTap;

  const MainMenuButtonsBlock({
    required this.onPlayTap,
    required this.onProfileTap,
    required this.onSettingsTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainButton.widget(
          onTap: onPlayTap,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/vector/play.svg',
                width: 24.r,
                height: 24.r,
                colorFilter: ColorFilter.mode(
                  context.appTheme.contrastIconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                context.locale.play,
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 16.sp,
                  color: context.appTheme.contrastTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        MainButton.widget(
          onTap: onProfileTap,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.profileIcon,
                width: 24.r,
                height: 24.r,
                colorFilter: ColorFilter.mode(
                  context.appTheme.contrastTextColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Profile',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 16.sp,
                  color: context.appTheme.contrastTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        MainButton.widget(
          onTap: onSettingsTap,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.settingsIcon,
                width: 24.r,
                height: 24.r,
                colorFilter: ColorFilter.mode(
                  context.appTheme.contrastTextColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Settings',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 16.sp,
                  color: context.appTheme.contrastTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        MainButton.widget(
          onTap: () {},
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          backgroundColor: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.achievementIcon,
                width: 24.r,
                height: 24.r,
                colorFilter: ColorFilter.mode(
                  context.appTheme.contrastIconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Help',
                textAlign: TextAlign.center,
                style: context.textTheme.headlineLarge?.copyWith(
                  fontSize: 16.sp,
                  color: context.appTheme.contrastTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
