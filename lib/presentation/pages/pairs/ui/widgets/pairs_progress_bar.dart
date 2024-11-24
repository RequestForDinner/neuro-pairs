import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class PairsProgressBar extends StatefulWidget {
  final int maxProgress;
  final int currentProgress;

  final double? height;

  const PairsProgressBar({
    required this.maxProgress,
    required this.currentProgress,
    this.height,
    super.key,
  });

  @override
  State<PairsProgressBar> createState() => _PairsProgressBarState();
}

class _PairsProgressBarState extends State<PairsProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(vsync: this);
  }

  @override
  void didUpdateWidget(covariant PairsProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentProgress != widget.currentProgress) {
      final progressPercent = widget.currentProgress * 100 / widget.maxProgress;

      _progressController.animateTo(
        progressPercent / 100,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }
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
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
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
