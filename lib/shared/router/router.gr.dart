// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:breeder/views/pages/main_menu_page.dart' as _i1;
import 'package:breeder/views/pages/new_breeding_page.dart' as _i2;
import 'package:breeder/views/widgets/genealogical_tree/second_gen_widget/second_gen_widget.dart'
    as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    MainMenuRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.MainMenuPage(),
      );
    },
    NewBreedingRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.NewBreedingPage(),
      );
    },
    SecondGenerationWidget.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SecondGenerationWidget(),
      );
    },
  };
}

/// generated route for
/// [_i1.MainMenuPage]
class MainMenuRoute extends _i4.PageRouteInfo<void> {
  const MainMenuRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MainMenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainMenuRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NewBreedingPage]
class NewBreedingRoute extends _i4.PageRouteInfo<void> {
  const NewBreedingRoute({List<_i4.PageRouteInfo>? children})
      : super(
          NewBreedingRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewBreedingRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SecondGenerationWidget]
class SecondGenerationWidget extends _i4.PageRouteInfo<void> {
  const SecondGenerationWidget({List<_i4.PageRouteInfo>? children})
      : super(
          SecondGenerationWidget.name,
          initialChildren: children,
        );

  static const String name = 'SecondGenerationWidget';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
