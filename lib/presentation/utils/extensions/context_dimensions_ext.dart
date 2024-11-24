import 'package:flutter/material.dart';

extension ContextDimensionsExt on BuildContext {
  double get availableWidth => MediaQuery.sizeOf(this).width;

  double get availableHeight => MediaQuery.sizeOf(this).height;

  EdgeInsets get viewPaddingOf => MediaQuery.viewPaddingOf(this);

  EdgeInsets get viewInsetsOf => MediaQuery.viewInsetsOf(this);
}
