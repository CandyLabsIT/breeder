import 'package:flutter/material.dart';

class AttributeValueButton extends StatelessWidget {
  final String _buttonText;
  final Color _buttonColor;
  final bool _isEnabled;
  final VoidCallback? _onPressed;

  const AttributeValueButton({
    required String buttonText,
    required Color buttonColor,
    required bool isEnabled,
    void Function()? onPressed,
    Key? key,
  })  : _isEnabled = isEnabled,
        _buttonColor = buttonColor,
        _buttonText = buttonText,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: GestureDetector(
        child: ElevatedButton(
          onPressed: _isEnabled ? _onPressed : null,
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: _buttonColor,
            elevation: 10,
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            minimumSize: const Size(140, 50),
            shape: const StadiumBorder(),
          ),
          child: Text(_buttonText),
        ),
      ),
    );
  }
}
