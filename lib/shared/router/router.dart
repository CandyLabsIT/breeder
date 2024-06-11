import 'package:auto_route/auto_route.dart';
import 'package:breeder/shared/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[
      AutoRoute(page: MainMenuRoute.page, initial: true),
      AutoRoute(page: NewBreedingRoute.page),
      AutoRoute(page: MaxIVFormRoute.page),
      AutoRoute(page: SecondGenerationWidget.page)
    ];
  }
}
