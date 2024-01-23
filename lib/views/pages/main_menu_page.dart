import 'package:auto_route/auto_route.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MainButton(
                buttonText: 'NEW BREEDING',
                onPressed: () => AutoRouter.of(context).push(const NewBreedingRoute()),
              ),
              const MainButton(buttonText: 'LOAD BREEDING'),
              const MainButton(buttonText: 'SETTINGS'),
              const MainButton(buttonText: 'CONTACT US'),
              const MainButton(buttonText: 'RATE US'),
            ],
          ),
        ),
      ),
    );
  }
}
