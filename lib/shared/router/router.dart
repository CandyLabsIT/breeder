import 'package:auto_route/auto_route.dart';
import 'package:breeder/shared/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes {
    return <AutoRoute>[];
  }
}