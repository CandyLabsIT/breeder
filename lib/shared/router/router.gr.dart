// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:breeder/views/pages/first_gen_page/first_gen_page.dart' as _i1;
import 'package:breeder/views/pages/main_menu_page.dart' as _i2;
import 'package:breeder/views/pages/max_iv_form_page/max_iv_form_page.dart'
    as _i3;
import 'package:breeder/views/pages/new_breeding_page.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    FirstGenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.FirstGenPage(),
      );
    },
    MainMenuRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MainMenuPage(),
      );
    },
    MaxIVFormRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MaxIVFormPage(),
      );
    },
    NewBreedingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.NewBreedingPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.FirstGenPage]
class FirstGenRoute extends _i5.PageRouteInfo<void> {
  const FirstGenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          FirstGenRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirstGenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MainMenuPage]
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
/// [_i3.MaxIVFormPage]
class MaxIVFormRoute extends _i5.PageRouteInfo<void> {
  const MaxIVFormRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MaxIVFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'MaxIVFormRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.NewBreedingPage]
class NewBreedingRoute extends _i5.PageRouteInfo<void> {
  const NewBreedingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          NewBreedingRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewBreedingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
