import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/app/theme/app_theme.dart';

final class AppThemeProvider extends StatelessWidget {
  const AppThemeProvider({
    required this.appTheme,
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context) builder;
  final AppTheme appTheme;

  static AppTheme of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedAppThemeProvider>();

    final theme = inheritedTheme?.appTheme;
    return theme ?? const AppTheme.light();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedAppThemeProvider(
      appTheme: appTheme,
      child: Builder(builder: builder),
    );
  }
}

final class _InheritedAppThemeProvider extends InheritedWidget {
  const _InheritedAppThemeProvider({
    required this.appTheme,
    required super.child,
  });

  final AppTheme appTheme;

  @override
  bool updateShouldNotify(_InheritedAppThemeProvider oldWidget) {
    return appTheme != oldWidget.appTheme;
  }
}
