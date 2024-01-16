import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required String buttonText,
    required void Function() onPressed,
    super.key,
  })  : _onPressed = onPressed,
        _buttonText = buttonText;

  final String _buttonText;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF000000),
          backgroundColor: const Color(0xFFfed291),
          elevation: 10,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          minimumSize: const Size(290, 70),
          shape: const StadiumBorder(),
        ),
        child: Text(_buttonText),
      ),
    );
  }
}