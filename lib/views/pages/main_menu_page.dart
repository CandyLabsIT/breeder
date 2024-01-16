import 'package:breeder/views/widgets/main_button.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MainButton(buttonText: 'NEW BREEDING', onPressed: () {}),
            MainButton(buttonText: 'LOAD BREEDING', onPressed: () {}),
            MainButton(buttonText: 'SETTINGS', onPressed: () {}),
            MainButton(buttonText: 'CONTACT US', onPressed: () {}),
            MainButton(buttonText: 'RATE US', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
