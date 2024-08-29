import 'package:breeder/views/widgets/genealogical_tree/buttons/attribute_value_button.dart';
import 'package:flutter/cupertino.dart';

class AttributeButtonsWidget extends StatelessWidget {
  final VoidCallback? onPressedAtk;
  final VoidCallback? onPressedHP;
  final VoidCallback? onPressedSpAtk;
  final VoidCallback? onPressedDef;
  final VoidCallback? onPressedSpDef;
  final VoidCallback? onPressedSpeed;

  final bool isEnabledAtk;
  final bool isEnabledHP;
  final bool isEnabledSpAtk;
  final bool isEnabledDef;
  final bool isEnabledSpDef;
  final bool isEnabledSpeed;

  const AttributeButtonsWidget({
    required this.onPressedAtk,
    required this.onPressedHP,
    required this.onPressedSpAtk,
    required this.onPressedDef,
    required this.onPressedSpDef,
    required this.onPressedSpeed,
    required this.isEnabledAtk,
    required this.isEnabledHP,
    required this.isEnabledSpAtk,
    required this.isEnabledDef,
    required this.isEnabledSpDef,
    required this.isEnabledSpeed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Atk.',
                buttonColor: const Color(0xFFFA4A78),
                isEnabled: isEnabledAtk,
                onPressed: onPressedAtk,
              ),
            ),
            Expanded(
              child: AttributeValueButton(
                buttonText: 'HP',
                buttonColor: const Color(0xFF7AE3FC),
                isEnabled: isEnabledHP,
                onPressed: onPressedHP,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Sp.Atk.',
                buttonColor: const Color(0xFFFDFB8E),
                isEnabled: isEnabledSpAtk,
                onPressed: onPressedSpAtk,
              ),
            ),
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Def.',
                buttonColor: const Color(0xFFFFDAD6),
                isEnabled: isEnabledDef,
                onPressed: onPressedDef,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Sp.Def.',
                buttonColor: const Color(0xFFCFA9F2),
                isEnabled: isEnabledSpDef,
                onPressed: onPressedSpDef,
              ),
            ),
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Speed',
                buttonColor: const Color(0xFF96EF9E),
                isEnabled: isEnabledSpeed,
                onPressed: onPressedSpeed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
