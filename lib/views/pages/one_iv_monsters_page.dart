import 'package:auto_route/auto_route.dart';
import 'package:breeder/shared/models/monsters_model.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:flutter/material.dart';

@RoutePage()
class OneIvMonstersPage extends StatelessWidget {
  final MonstersModel monstersModel;

  const OneIvMonstersPage({@PathParam('monster-model') required this.monstersModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomContainer(
      containerHeight: 650,
      containerWidth: 350,
      columnItems: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
          child: const Text(
            'Input the number of monsters with one IVs',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 300,
          child: Center(
            child: Row(
              children: <Widget>[
                CustomTextButton(
                  buttonText: 'Back',
                  icon: Icons.navigate_before,
                  leftMargin: 25,
                  onPressed: () => AutoRouter.of(context).push(const MonstersNumberRoute()),
                ),
                CustomTextButton(
                  buttonText: 'Cancel',
                  icon: Icons.cancel,
                  leftMargin: 25,
                  onPressed: () => AutoRouter.of(context).push(const MainMenuRoute()),
                ),
                const CustomTextButton(
                  buttonText: 'Next',
                  icon: Icons.navigate_next,
                  leftMargin: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
