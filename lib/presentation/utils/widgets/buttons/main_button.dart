import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

const _opacityInDuration = Duration(milliseconds: 180);
const _opacityOutDuration = Duration(milliseconds: 120);

final class MainButton extends StatefulWidget {
  final bool needExpandWidth;
  final double? width;
  final double? height;

  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? backgroundColor;

  final bool isActive;
  final bool needInactiveOpacity;
  final bool needInactiveColor;
  final bool needHover;

  final VoidCallback? onTap;

  final Duration opacityInDuration;
  final Duration opacityOutDuration;

  final String buttonText;
  final TextStyle? textStyle;

  final IconData? icon;
  final String? assetPath;
  final Color? iconColor;
  final Size? iconSize;

  final MainAxisAlignment? contentAlignment;

  final Widget? child;

  final TransitionButtonChildType transitionButtonChildType;

  const MainButton.text({
    required this.buttonText,
    this.needExpandWidth = false,
    this.width,
    this.height,
    this.textStyle,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.isActive = true,
    this.needInactiveOpacity = true,
    this.needInactiveColor = true,
    this.needHover = true,
    this.contentAlignment,
    this.onTap,
    this.opacityInDuration = _opacityInDuration,
    this.opacityOutDuration = _opacityOutDuration,
    super.key,
  })  : transitionButtonChildType = TransitionButtonChildType.text,
        icon = const IconData(-1),
        assetPath = '',
        iconColor = null,
        iconSize = null,
        child = null;

  const MainButton.textIcon({
    required this.buttonText,
    this.needExpandWidth = false,
    this.width,
    this.height,
    this.textStyle,
    this.icon,
    this.assetPath,
    this.iconColor,
    this.iconSize,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.isActive = true,
    this.needInactiveOpacity = true,
    this.needInactiveColor = true,
    this.needHover = true,
    this.contentAlignment,
    this.onTap,
    this.opacityInDuration = _opacityInDuration,
    this.opacityOutDuration = _opacityOutDuration,
    super.key,
  })  : transitionButtonChildType = TransitionButtonChildType.iconText,
        child = null,
        assert(
          !(icon != null && assetPath != null),
          'It is impossible to pass two icon parameters at the same time. '
          'However, the icon in the form of the path to the asset will '
          'be a priority in release mode.',
        );

  const MainButton.widget({
    this.needExpandWidth = false,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.border,
    this.backgroundColor,
    this.isActive = true,
    this.needInactiveOpacity = true,
    this.needInactiveColor = true,
    this.needHover = true,
    this.onTap,
    this.opacityInDuration = _opacityInDuration,
    this.opacityOutDuration = _opacityOutDuration,
    this.child,
    super.key,
  })  : transitionButtonChildType = TransitionButtonChildType.widget,
        buttonText = '',
        textStyle = null,
        icon = const IconData(-1),
        assetPath = '',
        iconColor = null,
        iconSize = null,
        contentAlignment = null;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton>
    with SingleTickerProviderStateMixin {
  late final Tween<double> _opacityTween;

  late final AnimationController _opacityController;
  late final Animation<double> _opacityAnimation;

  var _buttonHeldDown = false;
  var _canCallCallback = true;

  @override
  void initState() {
    super.initState();

    _opacityTween = Tween<double>(begin: 1, end: 0.4);

    _opacityController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: 0,
    );

    _opacityAnimation = _opacityController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
  }

  void _animateButtonOpacity([
    _AnimationDirection animationDirection = _AnimationDirection.animationIn,
  ]) {
    _buttonHeldDown = animationDirection == _AnimationDirection.animationOut;

    if (_opacityController.isAnimating) return;

    final buttonHeldDown = _buttonHeldDown;

    (_buttonHeldDown
            ? _opacityController.animateTo(
                1,
                duration: widget.opacityOutDuration,
                curve: Curves.easeInOutCubicEmphasized,
              )
            : _opacityController.animateTo(
                0,
                duration: widget.opacityInDuration,
                curve: Curves.easeOutCubic,
              ))
        .whenComplete(() {
      if (context.mounted && buttonHeldDown != _buttonHeldDown) {
        _animateButtonOpacity();
      }
    });
  }

  double? _sizeToDouble() {
    if (widget.iconSize == null) return null;

    return (widget.iconSize!.width + widget.iconSize!.height) / 2;
  }

  void _callback() {
    if (!_canCallCallback) return;
    _canCallCallback = false;
    widget.onTap?.call();
    Future.delayed(
      const Duration(milliseconds: 200),
      () => _canCallCallback = true,
    );
  }

  @override
  void dispose() {
    _opacityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: GestureDetector(
        onTap: widget.isActive ? _callback : null,
        onTapDown: widget.isActive && widget.needHover
            ? (_) => _animateButtonOpacity(_AnimationDirection.animationOut)
            : null,
        onTapUp: widget.needHover ? (_) => _animateButtonOpacity() : null,
        onTapCancel: _animateButtonOpacity,
        child: AnimatedOpacity(
          opacity: widget.needInactiveOpacity
              ? widget.isActive
                  ? 1
                  : 0.4
              : 1,
          duration: const Duration(milliseconds: 120),
          curve: Curves.decelerate,
          child: AnimatedContainer(
            width:
                widget.needExpandWidth ? context.availableWidth : widget.width,
            height: widget.height,
            margin: widget.margin ?? EdgeInsets.zero,
            padding: widget.padding ??
                const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? widget.backgroundColor ??
                      context.appTheme.activeElementColor
                  : widget.needInactiveColor
                      ? Colors.grey.shade400
                      : widget.backgroundColor ??
                          context.appTheme.activeElementColor,
              borderRadius: widget.borderRadius ??
                  const BorderRadius.all(
                    Radius.circular(16),
                  ),
              border: widget.border,
            ),
            duration: const Duration(milliseconds: 120),
            curve: Curves.decelerate,
            child: Builder(
              builder: (context) {
                return switch (widget.transitionButtonChildType) {
                  TransitionButtonChildType.text => Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          widget.contentAlignment ?? MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.buttonText,
                          style: widget.textStyle ??
                              context.textTheme.headlineLarge?.copyWith(
                                color: context.appTheme.contrastTextColor,
                              ),
                        ),
                      ],
                    ),
                  TransitionButtonChildType.iconText => Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment:
                          widget.contentAlignment ?? MainAxisAlignment.center,
                      children: <Widget>[
                        if (widget.assetPath != null)
                          SvgPicture.asset(
                            widget.assetPath!,
                            width: widget.iconSize?.width,
                            height: widget.iconSize?.height,
                            colorFilter: widget.iconColor != null
                                ? ColorFilter.mode(
                                    widget.iconColor!,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          )
                        else if (widget.icon != null &&
                            widget.assetPath == null)
                          Icon(
                            widget.icon,
                            size: _sizeToDouble(),
                            color: widget.iconColor,
                          ),
                        Text(
                          widget.buttonText,
                          style: widget.textStyle ??
                              context.textTheme.headlineLarge?.copyWith(
                                color: context.appTheme.contrastTextColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ].insertBetween(
                        const SizedBox(width: 16),
                      ),
                    ),
                  TransitionButtonChildType.widget =>
                    widget.child ?? const SizedBox(),
                };
              },
            ),
          ),
        ),
      ),
    );
  }
}

enum TransitionButtonChildType { text, iconText, widget }

enum _AnimationDirection { animationIn, animationOut }
