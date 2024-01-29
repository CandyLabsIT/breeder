// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:breeder/views/pages/main_menu_page.dart' as _i1;
import 'package:breeder/views/pages/new_breeding_page.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MainMenuRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainMenuPage(),
      );
    },
    NewBreedingRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.NewBreedingPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.MainMenuPage]
class MainMenuRoute extends _i3.PageRouteInfo<void> {
  const MainMenuRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MainMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainMenuRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NewBreedingPage]
class NewBreedingRoute extends _i3.PageRouteInfo<void> {
  const NewBreedingRoute({List<_i3.PageRouteInfo>? children})
      : super(
          NewBreedingRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewBreedingRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
