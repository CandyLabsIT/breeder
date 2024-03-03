// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:breeder/shared/models/monsters_model.dart' as _i6;
import 'package:breeder/views/pages/main_menu_page.dart' as _i1;
import 'package:breeder/views/pages/monsters_number_page.dart' as _i2;
import 'package:breeder/views/pages/new_breeding_page.dart' as _i3;
import 'package:breeder/views/pages/one_iv_monsters_page.dart' as _i4;
import 'package:flutter/material.dart' as _i7;

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
    OneIvMonstersRoute.name: (routeData) {
      final args = routeData.argsAs<OneIvMonstersRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.OneIvMonstersPage(
          monstersModel: args.monstersModel,
          key: args.key,
        ),
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
/// [_i4.OneIvMonstersPage]
class OneIvMonstersRoute extends _i5.PageRouteInfo<OneIvMonstersRouteArgs> {
  OneIvMonstersRoute({
    required _i6.MonstersModel monstersModel,
    _i7.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          OneIvMonstersRoute.name,
          args: OneIvMonstersRouteArgs(
            monstersModel: monstersModel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OneIvMonstersRoute';

  static const _i5.PageInfo<OneIvMonstersRouteArgs> page =
      _i5.PageInfo<OneIvMonstersRouteArgs>(name);
}

class OneIvMonstersRouteArgs {
  const OneIvMonstersRouteArgs({
    required this.monstersModel,
    this.key,
  });

  final _i6.MonstersModel monstersModel;

  final _i7.Key? key;

  @override
  String toString() {
    return 'OneIvMonstersRouteArgs{monstersModel: $monstersModel, key: $key}';
  }
}
