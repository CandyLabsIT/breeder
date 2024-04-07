import 'package:breeder/config/locator.dart';
import 'package:breeder/shared/router/router.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await initLocator();
  runApp(const CoreApp());
}

class CoreApp extends StatefulWidget {
  const CoreApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoreApp();
}

class _CoreApp extends State<CoreApp> {
  @override
  Widget build(BuildContext context) {
    AppRouter appRouter = AppRouter();
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      title: 'Breeder',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFFEAC5),
      ),
    );
  }
}
