import 'package:breeder/views/widgets/genealogical_tree/sliding_panel/buttons/attribute_value_button.dart';
import 'package:flutter/cupertino.dart';

class AttributeButtons extends StatelessWidget {
  final VoidCallback? _onPressedAtk;
  final VoidCallback? _onPressedHP;
  final VoidCallback? _onPressedSpAtk;
  final VoidCallback? _onPressedDef;
  final VoidCallback? _onPressedSpDef;
  final VoidCallback? _onPressedSpeed;

  final bool _isEnabledAtk;
  final bool _isEnabledHP;
  final bool _isEnabledSpAtk;
  final bool _isEnabledDef;
  final bool _isEnabledSpDef;
  final bool _isEnabledSpeed;

  const AttributeButtons({
    required void Function()? onPressedAtk,
    required void Function()? onPressedHP,
    required void Function()? onPressedSpAtk,
    required void Function()? onPressedDef,
    required void Function()? onPressedSpDef,
    required void Function()? onPressedSpeed,
    required bool isEnabledAtk,
    required bool isEnabledHP,
    required bool isEnabledSpAtk,
    required bool isEnabledDef,
    required bool isEnabledSpDef,
    required bool isEnabledSpeed,
    Key? key,
  })  : _onPressedAtk = onPressedAtk,
        _onPressedHP = onPressedHP,
        _onPressedSpAtk = onPressedSpAtk,
        _onPressedDef = onPressedDef,
        _onPressedSpDef = onPressedSpDef,
        _onPressedSpeed = onPressedSpeed,
        _isEnabledAtk = isEnabledAtk,
        _isEnabledHP = isEnabledHP,
        _isEnabledSpAtk = isEnabledSpAtk,
        _isEnabledDef = isEnabledDef,
        _isEnabledSpDef = isEnabledSpDef,
        _isEnabledSpeed = isEnabledSpeed,
        super(key: key);

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
                isEnabled: _isEnabledAtk,
                onPressed: _onPressedAtk,
              ),
            ),
            Expanded(
              child: AttributeValueButton(
                buttonText: 'HP',
                buttonColor: const Color(0xFF7AE3FC),
                isEnabled: _isEnabledHP,
                onPressed: _onPressedHP,
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
                isEnabled: _isEnabledSpAtk,
                onPressed: _onPressedSpAtk,
              ),
            ),
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Def.',
                buttonColor: const Color(0xFFFFDAD6),
                isEnabled: _isEnabledDef,
                onPressed: _onPressedDef,
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
                isEnabled: _isEnabledSpDef,
                onPressed: _onPressedSpDef,
              ),
            ),
            Expanded(
              child: AttributeValueButton(
                buttonText: 'Speed',
                buttonColor: const Color(0xFF96EF9E),
                isEnabled: _isEnabledSpeed,
                onPressed: _onPressedSpeed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
