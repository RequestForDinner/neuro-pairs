import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/neuro_pairs_localizations.dart';

extension ContextLocalizationExt on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this)!;
}
