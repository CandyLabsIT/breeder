import 'package:breeder/views/widgets/buttons/genealogical_tree/attribute_value/attribute_value_button.dart';
import 'package:flutter/cupertino.dart';

class ResetButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;

  const ResetButton({
    required this.onPressed,
    required this.isEnabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AttributeValueButton(
          buttonText: 'Reset',
          onPressed: onPressed,
          isEnabled: isEnabled,
          buttonColor: const Color(0xF095A5BF),
        ),
      ],
    );
  }
}
