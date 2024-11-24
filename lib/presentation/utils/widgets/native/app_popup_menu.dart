import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/vector_button.dart';

final class AppPopupMenu extends StatefulWidget {
  final BorderRadius shapeRadius;
  final List<AppPopupMenuItem> items;

  final String? svgPath;
  final Color? buttonIconColor;
  final Color? buttonBackgroundColor;
  final Gradient? buttonBackgroundGradient;
  final EdgeInsets? innerPadding;

  const AppPopupMenu({
    required this.items,
    this.shapeRadius = const BorderRadius.all(Radius.circular(16)),
    this.svgPath,
    this.buttonBackgroundColor,
    this.buttonBackgroundGradient,
    this.buttonIconColor,
    this.innerPadding,
    super.key,
  });

  @override
  State<AppPopupMenu> createState() => _AppPopupMenuState();
}

class _AppPopupMenuState extends State<AppPopupMenu> {
  late final GlobalKey _popupButtonKey;

  @override
  void initState() {
    super.initState();

    _popupButtonKey = GlobalKey();
  }

  Future<void> _showPopupMenu(BuildContext context) async {
    if (!context.mounted) return;

    final popupButtonRenderBox =
        _popupButtonKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Navigator.of(
      context,
    ).overlay?.context.findRenderObject() as RenderBox?;

    if (popupButtonRenderBox == null || overlay == null) return;

    final popupButtonHeight = popupButtonRenderBox.size.height;

    final mainOffset = Offset(0, popupButtonHeight + 8) + Offset.zero;

    final menuPosition = RelativeRect.fromRect(
      Rect.fromPoints(
        popupButtonRenderBox.localToGlobal(
          mainOffset,
          ancestor: overlay,
        ),
        popupButtonRenderBox.localToGlobal(
          popupButtonRenderBox.size.bottomRight(Offset.zero) + mainOffset,
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    return showMenu(
      context: context,
      color: Colors.white,
      elevation: 4,
      position: menuPosition,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black,
      menuPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: widget.shapeRadius,
      ),
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 400),
        reverseCurve: Curves.fastOutSlowIn,
        reverseDuration: const Duration(milliseconds: 300),
      ),
      items: [
        for (final item in widget.items) _AppPopupMenuEntry(child: item),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 30,
      child: VectorButton.iconData(
        key: _popupButtonKey,
        onTap: () => _showPopupMenu(context),
        iconData: Icons.edit,
        iconColor: widget.buttonIconColor ?? context.appTheme.contrastIconColor,
        iconSize: const Size(16, 16),
        backgroundColor: widget.buttonBackgroundColor,
        innerPadding: widget.innerPadding ?? EdgeInsets.zero,
      ),
    );
  }
}

final class AppPopupMenuItem extends StatelessWidget {
  final VoidCallback? onTap;

  final String itemText;
  final String? iconAssetPath;
  final IconData? icon;

  final bool withDivider;

  const AppPopupMenuItem({
    required this.itemText,
    this.iconAssetPath,
    this.icon,
    this.onTap,
    this.withDivider = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainButton.textIcon(
          margin: EdgeInsets.zero,
          onTap: onTap,
          buttonText: itemText,
          icon: icon,
          iconColor: context.appTheme.primaryIconColor,
          backgroundColor: Colors.transparent,
          assetPath: iconAssetPath,
          textStyle: context.textTheme.headlineMedium,
        ),
        if (withDivider) const Divider(height: 32),
      ],
    );
  }
}

final class _AppPopupMenuEntry extends PopupMenuItem {
  const _AppPopupMenuEntry({
    super.child,
  }) : super(
          padding: EdgeInsets.zero,
          height: 0,
          onTap: null,
          enabled: false,
        );
}
