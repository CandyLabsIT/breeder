import 'package:flutter/material.dart';

class AttributeValueButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  final Color buttonColor;
  final bool isEnabled;

  const AttributeValueButton({
    required this.buttonText,
    required this.buttonColor,
    required this.isEnabled,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: GestureDetector(
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: buttonColor,
            elevation: 10,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            minimumSize: const Size(140, 50),
            shape: const StadiumBorder(),
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
