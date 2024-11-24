import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class PairsLoadingBody extends StatefulWidget {
  const PairsLoadingBody({super.key});

  @override
  State<PairsLoadingBody> createState() => _PairsLoadingBodyState();
}

class _PairsLoadingBodyState extends State<PairsLoadingBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  var _dots = '.';

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _initializeAnimatedDots();
  }

  void _initializeAnimatedDots() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 300),
      (_) => setState(() => _dots = _dots == '...' ? '.' : '$_dots.'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _timer = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox.square(
              dimension: 150,
              child: Lottie.asset(
                'assets/animations/lottie/primary_loading.json',
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Load images$_dots',
            style: context.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
