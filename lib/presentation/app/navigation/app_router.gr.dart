// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i12;
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart' as _i13;
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart' as _i11;
import 'package:neuro_pairs/presentation/pages/auth/auth_page.dart' as _i1;
import 'package:neuro_pairs/presentation/pages/main/ui/main_page.dart' as _i2;
import 'package:neuro_pairs/presentation/pages/pairs/ui/pairs_page.dart' as _i4;
import 'package:neuro_pairs/presentation/pages/pairs_categories/ui/pairs_categories_page.dart'
    as _i3;
import 'package:neuro_pairs/presentation/pages/pairs_settings/ui/pairs_settings_page.dart'
    as _i5;
import 'package:neuro_pairs/presentation/pages/profile/ui/profile_page.dart'
    as _i7;
import 'package:neuro_pairs/presentation/pages/profile_edit/ui/profile_edit_page.dart'
    as _i6;
import 'package:neuro_pairs/presentation/pages/settings/ui/settings_page.dart'
    as _i8;
import 'package:neuro_pairs/presentation/pages/statistic/ui/statistic_page.dart'
    as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MainPage(),
      );
    },
    PairsCategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<PairsCategoriesRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.PairsCategoriesPage(
          pairsSettings: args.pairsSettings,
          key: args.key,
        ),
      );
    },
    PairsRoute.name: (routeData) {
      final args = routeData.argsAs<PairsRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.PairsPage(
          pairsGame: args.pairsGame,
          key: args.key,
        ),
      );
    },
    PairsSettingsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.PairsSettingsPage(),
      );
    },
    ProfileEditRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileEditPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ProfilePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsPage(),
      );
    },
    StatisticRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.StatisticPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute({List<_i10.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MainPage]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute({List<_i10.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.PairsCategoriesPage]
class PairsCategoriesRoute
    extends _i10.PageRouteInfo<PairsCategoriesRouteArgs> {
  PairsCategoriesRoute({
    required _i11.PairsSettings? pairsSettings,
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PairsCategoriesRoute.name,
          args: PairsCategoriesRouteArgs(
            pairsSettings: pairsSettings,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PairsCategoriesRoute';

  static const _i10.PageInfo<PairsCategoriesRouteArgs> page =
      _i10.PageInfo<PairsCategoriesRouteArgs>(name);
}

class PairsCategoriesRouteArgs {
  const PairsCategoriesRouteArgs({
    required this.pairsSettings,
    this.key,
  });

  final _i11.PairsSettings? pairsSettings;

  final _i12.Key? key;

  @override
  String toString() {
    return 'PairsCategoriesRouteArgs{pairsSettings: $pairsSettings, key: $key}';
  }
}

/// generated route for
/// [_i4.PairsPage]
class PairsRoute extends _i10.PageRouteInfo<PairsRouteArgs> {
  PairsRoute({
    required _i13.PairsGame pairsGame,
    _i12.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          PairsRoute.name,
          args: PairsRouteArgs(
            pairsGame: pairsGame,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PairsRoute';

  static const _i10.PageInfo<PairsRouteArgs> page =
      _i10.PageInfo<PairsRouteArgs>(name);
}

class PairsRouteArgs {
  const PairsRouteArgs({
    required this.pairsGame,
    this.key,
  });

  final _i13.PairsGame pairsGame;

  final _i12.Key? key;

  @override
  String toString() {
    return 'PairsRouteArgs{pairsGame: $pairsGame, key: $key}';
  }
}

/// generated route for
/// [_i5.PairsSettingsPage]
class PairsSettingsRoute extends _i10.PageRouteInfo<void> {
  const PairsSettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          PairsSettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PairsSettingsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ProfileEditPage]
class ProfileEditRoute extends _i10.PageRouteInfo<void> {
  const ProfileEditRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileEditRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute({List<_i10.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.StatisticPage]
class StatisticRoute extends _i10.PageRouteInfo<void> {
  const StatisticRoute({List<_i10.PageRouteInfo>? children})
      : super(
          StatisticRoute.name,
          initialChildren: children,
        );

  static const String name = 'StatisticRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
