// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:breeder/views/pages/main_menu_page.dart' as _i1;
import 'package:breeder/views/pages/new_breeding_page.dart' as _i2;
import 'package:breeder/views/widgets/genealogical_tree/second_gen/second_gen_page.dart'
    as _i3;
import 'package:breeder/views/widgets/generic/third_generation/third_gen_page.dart'
    as _i4;

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
    NewBreedingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.NewBreedingPage(),
      );
    },
    SecondGenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SecondGenPage(),
      );
    },
    ThirdGenRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ThirdGenPage(),
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
/// [_i2.NewBreedingPage]
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
/// [_i3.SecondGenPage]
class SecondGenRoute extends _i5.PageRouteInfo<void> {
  const SecondGenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SecondGenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecondGenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ThirdGenPage]
class ThirdGenRoute extends _i5.PageRouteInfo<void> {
  const ThirdGenRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ThirdGenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThirdGenRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
