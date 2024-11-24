import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class AppChildDialog extends StatelessWidget {
  final Widget child;

  const AppChildDialog({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: context.availableWidth * 0.9,
          child: Material(
            color: context.appTheme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
