import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/vector_button.dart';

final class CustomAppBar extends StatelessWidget {
  final Widget? title;

  final String? titleText;
  final TextStyle? titleStyle;

  final String? leadingSvgPath;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingTap;

  final Widget? leading;

  final List<Widget>? actions;
  final List<Widget>? upperActions;

  final EdgeInsets margin;

  const CustomAppBar({
    this.title,
    this.titleText,
    this.titleStyle,
    this.leadingSvgPath,
    this.leadingIcon,
    this.onLeadingTap,
    this.leading,
    this.actions,
    this.upperActions,
    this.margin = EdgeInsets.zero,
    super.key,
  })  : assert(
          !(title != null && titleText != null),
          'Either title or titleText',
        ),
        assert(
          !(leadingIcon != null && leadingSvgPath != null),
          'Either leadingIcon or leadingSvgPath',
        ),
        assert(
          !(leading != null &&
              (leadingSvgPath != null ||
                  leadingIcon != null ||
                  onLeadingTap != null)),
          'Either leading or leading callback and icons',
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: context.viewPaddingOf.top + 8),
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  if (leading == null &&
                      (leadingSvgPath != null || leadingIcon != null))
                    _LeadingButton(
                      leadingSvgPath: leadingSvgPath,
                      leadingIcon: leadingIcon,
                      onLeadingTap: () {
                        SoundsAndEffectsService.instance.playTapSound();
                        onLeadingTap?.call();
                      },
                    )
                  else if (leading != null)
                    leading!,
                  const Spacer(),
                  if (actions != null) ...actions!,
                ],
              ),
              if (upperActions != null)
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(children: upperActions!),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                titleText == null
                    ? title ?? const SizedBox()
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          titleText!,
                          key: ValueKey<String>(titleText!),
                          style: titleStyle ??
                              context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final class _LeadingButton extends StatelessWidget {
  final String? leadingSvgPath;
  final IconData? leadingIcon;

  final VoidCallback? onLeadingTap;

  const _LeadingButton({
    this.leadingSvgPath,
    this.leadingIcon,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return leadingSvgPath == null
        ? VectorButton.iconData(
            iconData: leadingIcon!,
            iconColor: context.appTheme.primaryIconColor,
            onTap: onLeadingTap,
          )
        : VectorButton.assetPath(
            assetPath: leadingSvgPath!,
            iconColor: context.appTheme.primaryIconColor,
            onTap: onLeadingTap,
          );
  }
}
