import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/horizontal_insets.dart';

final class ProfileControlButtons extends StatelessWidget {
  const ProfileControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            HorizontalInsets(
              child: Row(
                children: [
                  Expanded(
                    child: _ControlButton(
                      buttonText: 'Edit',
                      assetPath: AppAssets.edit,
                      iconColor: context.appTheme.primaryIconColor,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: _ControlButton(
                      buttonText: 'Statistic',
                      assetPath: AppAssets.statistic,
                      iconColor: context.appTheme.primaryIconColor,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: _ControlButton(
                      buttonText: 'Statistic',
                      assetPath: AppAssets.infoIcon,
                      iconColor: context.appTheme.primaryIconColor,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: context.appTheme.mainBackground, height: 32),
            HorizontalInsets(
              child: Row(
                children: [
                  Expanded(
                    child: _ControlButton(
                      buttonText: 'Help',
                      assetPath: AppAssets.help,
                      iconColor: context.appTheme.primaryIconColor,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: _ControlButton(
                      buttonText: 'Exit',
                      assetPath: AppAssets.exit,
                      iconColor: context.appTheme.primaryIconColor,
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: _ControlButton(
                      buttonText: 'Delete account',
                      assetPath: AppAssets.trash,
                      iconColor: context.appTheme.primaryIconColor,
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

final class _ControlButton extends StatelessWidget {
  final String buttonText;
  final String assetPath;

  final Color iconColor;

  final VoidCallback onTap;

  const _ControlButton({
    required this.buttonText,
    required this.assetPath,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton.widget(
      backgroundColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            assetPath,
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(height: 16),
          FittedBox(
            child: Text(
              buttonText,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.appTheme.secondaryTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
