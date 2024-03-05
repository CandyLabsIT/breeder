// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:breeder/views/pages/main_menu_page.dart' as _i1;
import 'package:breeder/views/pages/monsters_number_page.dart' as _i2;
import 'package:breeder/views/pages/new_breeding_page.dart' as _i3;
import 'package:breeder/views/pages/single_iv_creator_page.dart' as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    MainMenuRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainMenuPage(),
      );
    },
    MonstersNumberRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MonstersNumberPage(),
      );
    },
    NewBreedingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.NewBreedingPage(),
      );
    },
    SingleIVCreatorRoute.name: (routeData) {
      final args = routeData.argsAs<SingleIVCreatorRouteArgs>(
          orElse: () => const SingleIVCreatorRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SingleIVCreatorPage(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.MainMenuPage]
class MainMenuRoute extends _i5.PageRouteInfo<void> {
  const MainMenuRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainMenuRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MonstersNumberPage]
class MonstersNumberRoute extends _i5.PageRouteInfo<void> {
  const MonstersNumberRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MonstersNumberRoute.name,
          initialChildren: children,
        );

  static const String name = 'MonstersNumberRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.NewBreedingPage]
class NewBreedingRoute extends _i5.PageRouteInfo<void> {
  const NewBreedingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          NewBreedingRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewBreedingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SingleIVCreatorPage]
class SingleIVCreatorRoute extends _i5.PageRouteInfo<SingleIVCreatorRouteArgs> {
  SingleIVCreatorRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SingleIVCreatorRoute.name,
          args: SingleIVCreatorRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SingleIVCreatorRoute';

  static const _i5.PageInfo<SingleIVCreatorRouteArgs> page =
      _i5.PageInfo<SingleIVCreatorRouteArgs>(name);
}

class SingleIVCreatorRouteArgs {
  const SingleIVCreatorRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'SingleIVCreatorRouteArgs{key: $key}';
  }
}
