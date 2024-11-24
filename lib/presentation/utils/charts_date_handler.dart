import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';

abstract final class ChartsDateHandler {
  static String weekDayName(BuildContext context, int dayFromCurrentDate) {
    final now = DateTime.now();
    final weekDateFromCurrentDate = now.copyWith(
      day: now.day - dayFromCurrentDate,
    );

    return DateFormat(
      'EEE',
      context.locale.localeName,
    ).format(weekDateFromCurrentDate);
  }
}
