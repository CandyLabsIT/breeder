import 'package:flutter/material.dart';

class ClosePanelWidget extends StatelessWidget {
  const ClosePanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.arrow_drop_down,
          size: 24,
        ),
      ],
    );
  }
}
