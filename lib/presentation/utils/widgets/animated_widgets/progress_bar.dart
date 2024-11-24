import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class ProgressBar extends StatefulWidget {
  final int endProgressValue;
  final int startProgressValue;
  final int currentProgressValue;

  final double? height;

  const ProgressBar({
    required this.endProgressValue,
    required this.startProgressValue,
    required this.currentProgressValue,
    this.height,
    super.key,
  });

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(vsync: this);

    _animateProgressBar(
      const Duration(milliseconds: 600),
    );
  }

  void _animateProgressBar([Duration? duration]) {
    final progressPercent = _calculatePercent();

    _progressController.animateTo(
      progressPercent / 100,
      duration: duration ?? const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentProgressValue != widget.currentProgressValue) {
      _animateProgressBar();
    }
  }

  int _calculatePercent() {
    final maxMinSub = widget.endProgressValue - widget.startProgressValue;
    final currentMinSub =
        widget.currentProgressValue - widget.startProgressValue;

    return ((currentMinSub) / (maxMinSub) * 100).toInt();
  }

  @override
  void dispose() {
    _progressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: widget.height ?? 8,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.appTheme.nonActiveElementColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            return Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: widget.height ?? 8,
                    child: FractionallySizedBox(
                      widthFactor: _progressController.value,
                      alignment: Alignment.centerLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: context.appTheme.activeElementColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
