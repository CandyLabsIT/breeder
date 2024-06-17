import 'package:flutter/material.dart';

class ClosePanelWidget extends StatelessWidget {
  const ClosePanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Close',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Icon(
          Icons.arrow_drop_down,
          size: 24,
        ),
      ],
    );
  }
}
