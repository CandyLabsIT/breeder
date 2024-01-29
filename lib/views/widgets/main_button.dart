import 'package:flutter/material.dart';

class MainButton extends StatefulWidget {
  final VoidCallback? _onPressed;
  final String _buttonText;

  const MainButton({
    required String buttonText,
    void Function()? onPressed,
    Key? key,
  })  : _onPressed = onPressed,
        _buttonText = buttonText,
        super(key: key);

  @override
  State<MainButton> createState() {
    return _MainButtonState();
  }
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: widget._onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFF000000),
          backgroundColor: const Color(0xFFfed291),
          shadowColor: const Color(0xffd2d2d2),
          elevation: 10,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size(290, 70),
          shape: const StadiumBorder(),
        ),
        // maximumSize: MaterialStateProperty.all<Size>()
        child: Text(widget._buttonText),
      ),
    );
  }
}
