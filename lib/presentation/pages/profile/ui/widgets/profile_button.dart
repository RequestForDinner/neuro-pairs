import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class ProfileButton extends StatelessWidget {
  final String buttonText;
  final String iconPath;
  final Color? iconColor;
  final VoidCallback? onTap;

  const ProfileButton({
    required this.buttonText,
    required this.iconPath,
    this.iconColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton.widget(
      backgroundColor: Colors.transparent,
      padding: const EdgeInsets.symmetric( vertical: 14),
      onTap: onTap,
      child: Row(
        children: [
          Text(
            buttonText,
            style: context.textTheme.headlineLarge,
          ),
          const Spacer(),
          DecoratedBox(
            decoration: BoxDecoration(
              color: context.appTheme.nonActiveElementColor,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                iconPath,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  iconColor ?? context.appTheme.primaryIconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
