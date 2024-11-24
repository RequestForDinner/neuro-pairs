import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class LoadingShell extends StatelessWidget {
  final Widget body;

  final bool loadingCondition;

  const LoadingShell({
    required this.body,
    required this.loadingCondition,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.fastOutSlowIn,
          switchOutCurve: Curves.fastOutSlowIn,
          child: loadingCondition
              ? SizedBox(
                  width: context.availableWidth,
                  height: context.availableHeight,
                  child: ColoredBox(
                    color: Colors.black45,
                    child: CupertinoActivityIndicator(
                      color: context.appTheme.contrastTextColor,
                    ),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
