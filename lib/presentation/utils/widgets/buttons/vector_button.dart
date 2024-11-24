import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class VectorButton extends StatelessWidget {
  final String assetPath;
  final IconData iconData;
  final Size? iconSize;
  final Color? iconColor;

  final Color? backgroundColor;

  final VoidCallback? onTap;

  final bool withAssetPath;

  final bool needInnerPadding;
  final EdgeInsets? innerPadding;

  final bool isActive;
  final bool needHover;

  const VectorButton.assetPath({
    required this.assetPath,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.needInnerPadding = true,
    this.onTap,
    this.innerPadding,
    this.isActive = true,
    this.needHover = true,
    super.key,
  })  : withAssetPath = true,
        iconData = const IconData(-1);

  const VectorButton.iconData({
    required this.iconData,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.needInnerPadding = true,
    this.onTap,
    this.innerPadding,
    this.isActive = true,
    this.needHover = true,
    super.key,
  })  : withAssetPath = false,
        assetPath = '';

  double _sizeToDouble() {
    if (iconSize == null) {
      const defaultIconSize = Size(24, 24);

      return (defaultIconSize.width + defaultIconSize.height) / 2;
    }

    return (iconSize!.width + iconSize!.height) / 2;
  }

  @override
  Widget build(BuildContext context) {
    return MainButton.widget(
      onTap: onTap,
      isActive: isActive,
      needInactiveColor: false,
      needHover: needHover,
      padding: needInnerPadding
          ? innerPadding ?? const EdgeInsets.all(8)
          : EdgeInsets.zero,
      borderRadius: const BorderRadius.all(
        Radius.circular(32),
      ),
      backgroundColor: backgroundColor ?? Colors.transparent,
      child: Center(
        child: withAssetPath
            ? SvgPicture.asset(
                assetPath,
                width: iconSize?.width ?? 24.r,
                height: iconSize?.height ?? 24.r,
                colorFilter: ColorFilter.mode(
                  iconColor ?? context.appTheme.primaryIconColor,
                  BlendMode.srcIn,
                ),
              )
            : Icon(
                iconData,
                size: _sizeToDouble().r,
                color: iconColor ?? context.appTheme.primaryIconColor,
              ),
      ),
    );
  }
}
