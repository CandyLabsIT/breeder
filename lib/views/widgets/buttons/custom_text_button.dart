import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String _buttonText;
  final IconData? _icon;
  final double _leftMargin;
  final VoidCallback? _onPressed;

  const CustomTextButton({
    required String buttonText,
    required double leftMargin,
    IconData? icon,
    void Function()? onPressed,
    Key? key,
  })  : _buttonText = buttonText,
        _icon = icon,
        _leftMargin = leftMargin,
        _onPressed = onPressed,
        super(key: key);

  @override
  State<CustomTextButton> createState() {
    return _CustomTextButtonState();
  }
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 35.0,
        left: widget._leftMargin,
      ),
      child: TextButton(
        onPressed: widget._onPressed,

        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                widget._icon,
                color: Colors.black,
              ),
            ),
            Text(widget._buttonText),
          ],
        ),
      ),
    );
  }
}
