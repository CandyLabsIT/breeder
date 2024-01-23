import 'package:auto_route/auto_route.dart';
import 'package:breeder/shared/router/router.gr.dart';
import 'package:breeder/views/widgets/buttons/custom_text_button.dart';
import 'package:breeder/views/widgets/generic/custom_container.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewBreedingPage extends StatefulWidget {
  const NewBreedingPage({super.key});

  @override
  State<NewBreedingPage> createState() {
    return _NewBreedingState();
  }
}

class _NewBreedingState extends State<NewBreedingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        containerWidth: 325,
        containerHeight: 270,
        columnItems: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 10),
            child: const Text(
              'New breeding',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 250,
            child: TextField(
              enableInteractiveSelection: false,
              maxLines: 1,
              maxLength: 20,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Color(0xFF727272),
                  fontSize: 15,
                  height: 0,
                ),
                labelText: 'Title (optional)',
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              textAlign: TextAlign.left,
              cursorColor: Colors.black,
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ),
          SizedBox(
            width: 300,
            child: Center(
              child: Row(
                children: <Widget>[
                  CustomTextButton(
                    buttonText: 'Cancel',
                    icon: Icons.cancel,
                    leftMargin: 55,
                    onPressed: () => AutoRouter.of(context).push(const MainMenuRoute()),
                  ),
                  CustomTextButton(
                    buttonText: 'Next',
                    icon: Icons.navigate_next,
                    leftMargin: 55,
                    onPressed: () => AutoRouter.of(context).push(const MaxIVFormRoute()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
