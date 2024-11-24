import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class AnimatedLoadingFullscreen extends StatelessWidget {
  final bool needLoading;

  const AnimatedLoadingFullscreen({required this.needLoading, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: needLoading
          ? ColoredBox(
              color: context.appTheme.mainBackground,
              child: Center(
                child: Lottie.asset(
                  'assets/animations/lottie/primary_loading.json',
                  width: 100,
                  height: 100,
                ),
              ),
            )
          : null,
    );
  }
}
