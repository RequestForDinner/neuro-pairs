import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class SettingsButton extends StatelessWidget {
  final String text;
  final String svgPath;
  final String? supportText;

  final VoidCallback? onTap;

  final bool withNavigation;

  const SettingsButton({
    required this.text,
    required this.svgPath,
    this.onTap,
    this.withNavigation = true,
    this.supportText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton.widget(
      onTap: () {
        SoundsAndEffectsService.instance.playTapSound();
        onTap?.call();
      },
      needExpandWidth: true,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          SvgPicture.asset(
            svgPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              context.appTheme.primaryIconColor,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.headlineMedium,
            ),
          ),
          if (withNavigation) ...[
            DecoratedBox(
              decoration: BoxDecoration(
                color: context.appTheme.nonActiveElementColor,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
              ),
              child: SizedBox.square(
                dimension: 50,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.appTheme.primaryIconColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
