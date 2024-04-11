import 'package:auto_route/auto_route.dart';
import 'package:breeder/views/pages/iv_creator/wrapper/creator_process_wrapper.dart';
import 'package:flutter/material.dart';

@RoutePage()
class IVCreatorPage extends StatefulWidget {
  const IVCreatorPage({super.key});

  @override
  State<StatefulWidget> createState() => _IVCreatorPage();
}

class _IVCreatorPage extends State<IVCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: CreatorProcessWrapper(),
        ),
      ),
    );
  }
}
