import 'package:auto_route/auto_route.dart'
    show AutoRoute, AutoRouteGuard, AutoRouterConfig, CustomRoute, PageInfo;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/app/navigation/guards/auth_guard.dart';

@AutoRouterConfig()
final class AppRouter extends $AppRouter {
  static final _navigationInstance = AppRouter._();

  AppRouter._();

  static AppRouter get navigationInstance => _navigationInstance;

  @override
  List<AutoRoute> get routes => [
        _slideTransitionRoute(page: AuthRoute.page),
        _cupertinoTransitionRoute(
          page: MainRoute.page,
          initial: true,
          guards: [Injector.instance.instanceOf<AuthGuard>()],
        ),
        _cupertinoTransitionRoute(page: PairsRoute.page),
        _cupertinoTransitionRoute(page: PairsSettingsRoute.page),
        _cupertinoTransitionRoute(page: PairsCategoriesRoute.page),
        _cupertinoTransitionRoute(page: SettingsRoute.page),
        _cupertinoTransitionRoute(page: ProfileRoute.page),
        _cupertinoTransitionRoute(page: ProfileEditRoute.page),
        _cupertinoTransitionRoute(page: StatisticRoute.page),
      ];

  CustomRoute _cupertinoTransitionRoute({
    required PageInfo page,
    bool initial = false,
    List<AutoRouteGuard> guards = const [],
  }) {
    return CustomRoute(
      page: page,
      initial: initial,
      guards: guards,
      transitionsBuilder: (_, primaryAnimation, secondaryAnimation, child) {
        return Builder(
          builder: (context) {
            return CupertinoPageTransition(
              primaryRouteAnimation: primaryAnimation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        );
      },
      customRouteBuilder: (_, child, settings) {
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => child,
        );
      },
    );
  }

  CustomRoute _slideTransitionRoute({
    required PageInfo page,
    bool initial = false,
    List<AutoRouteGuard> guards = const [],
  }) {
    return CustomRoute(
      page: page,
      initial: initial,
      guards: guards,
      transitionsBuilder: (_, primaryAnimation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: primaryAnimation,
          curve: curve,
        );

        return Builder(
          builder: (context) {
            return ColoredBox(
              color: Colors.white, //context.appTheme.mainBackground,
              child: SlideTransition(
                position: tween.animate(curvedAnimation),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
