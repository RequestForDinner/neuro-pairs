import 'package:flutter/cupertino.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';

extension PresentationIntExt on int {
  String hoursAndMinutesAmount(BuildContext context) {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;

    if (hours == 0 && minutes == 0) {
      return context.locale.minutesAmountPartly(0);
    } else if (hours == 0) {
      return context.locale.minutesAmountPartly(minutes);
    } else if (minutes == 0) {
      return context.locale.hoursAmountPartly(hours);
    } else {
      return '${context.locale.hoursAmountPartly(hours)} '
          '${context.locale.minutesAmountPartly(minutes)}';
    }
  }

  String minutesAmount() {
    final minutesLeft = this ~/ 60;

    return minutesLeft.toString();
  }

  String secondsAmount() {
    final secondsLeft = this % 60;

    return secondsLeft.toString();
  }
}
