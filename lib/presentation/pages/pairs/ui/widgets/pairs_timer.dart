import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class PairsTimer extends StatefulWidget {
  final Duration duration;

  final VoidCallback onTimeEnd;
  final ValueSetter<int> onTimeReceive;

  const PairsTimer({
    required this.duration,
    required this.onTimeEnd,
    required this.onTimeReceive,
    super.key,
  });

  @override
  State<PairsTimer> createState() => _PairsTimerState();
}

class _PairsTimerState extends State<PairsTimer> with TickerProviderStateMixin {
  late final AnimationController _timerController;
  late final AnimationController _fadeController;

  Timer? _timer;
  var _timerDuration = Duration.zero;
  var _secondsAmount = 0;

  static const _needPercent = 20;

  @override
  void initState() {
    super.initState();

    _timerController = AnimationController(vsync: this);
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      value: 1,
    );

    _timerDuration = widget.duration;
  }

  void _startTimer() {
    _cancelTimer();
    var alreadyEnd = false;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (context.mounted) {
          _secondsAmount++;

          if (_timerDuration.inSeconds == 0) {
            if (!alreadyEnd) {
              alreadyEnd = true;
              widget.onTimeEnd();

              _fadeController.stop();
              _fadeAnimateTo(1);
              _timerController.stop();
            }
          } else {
            setState(
              () => _timerDuration = Duration(
                seconds: _timerDuration.inSeconds - 1,
              ),
            );
          }

          if (!_fadeController.isAnimating && _timerDuration.inSeconds > 0) {
            _repeatTimerFadeAnimation();
          }
        }
      },
    );
  }

  void _repeatTimerFadeAnimation() {
    final currentSecondsPercent =
        (_timerDuration.inSeconds / widget.duration.inSeconds) * 100;

    if (currentSecondsPercent <= _needPercent) _repeatAnimation();
  }

  void _repeatAnimation() {
    _fadeAnimateTo(0.2).whenComplete(
      () => _fadeAnimateTo(1).whenComplete(_repeatAnimation),
    );
  }

  Future<void> _fadeAnimateTo(double target) async {
    await _fadeController.animateTo(
      target,
      duration: const Duration(milliseconds: 700),
    );
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timerController.dispose();
    _fadeController.dispose();

    _cancelTimer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPercent =
        (_timerDuration.inSeconds / widget.duration.inSeconds) * 100;

    return BlocListener<PairsCubit, PairsState>(
      listener: (_, state) {
        if (state.needStartTimer) {
          _startTimer();
        } else {
          _cancelTimer();
          widget.onTimeReceive(_secondsAmount);
        }
      },
      listenWhen: (prev, curr) => prev.needStartTimer != curr.needStartTimer,
      child: FadeTransition(
        opacity: _fadeController,
        child: Row(
          children: [
            SizedBox.square(
              dimension: 24,
              child: Lottie.asset(
                'assets/animations/lottie/time.json',
                controller: _timerController,
                onLoaded: (composition) => _timerController
                  ..duration = composition.duration
                  ..repeat(),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _printDuration(_timerDuration),
              style: context.textTheme.headlineSmall?.copyWith(
                color:
                    currentPercent <= _needPercent ? Colors.red : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _twoDigits(int n) => n.toString().padLeft(2, "0");

  String _printDuration(Duration duration) {
    final negativeSign = duration.isNegative ? '-' : '';
    final twoDigitMinutes = _twoDigits(duration.inMinutes.remainder(60).abs());
    final twoDigitSeconds = _twoDigits(duration.inSeconds.remainder(60).abs());
    return '$negativeSign$twoDigitMinutes:$twoDigitSeconds';
  }
}
