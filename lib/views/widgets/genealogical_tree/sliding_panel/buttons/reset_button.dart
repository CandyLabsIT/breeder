import 'package:breeder/views/widgets/genealogical_tree/sliding_panel/buttons/attribute_value_button.dart';
import 'package:flutter/cupertino.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback? _onPressed;
  final bool _isEnabled;

  const ResetButton({
    required void Function()? onPressed,
    required bool isEnabled,
    Key? key,
  })  : _onPressed = onPressed,
        _isEnabled = isEnabled,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AttributeValueButton(
          buttonText: 'Reset',
          onPressed: _onPressed,
          isEnabled: _isEnabled,
          buttonColor: const Color(0xF095A5BF),
        ),
      ],
    );
  }
}
