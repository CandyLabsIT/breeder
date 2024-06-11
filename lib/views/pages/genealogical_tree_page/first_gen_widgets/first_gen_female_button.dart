import 'package:breeder/views/widgets/genealogical_tree/branch_lines/female_branch_line_painter.dart';
import 'package:flutter/material.dart';

class FirstGenFemaleButton extends StatelessWidget {
  final Color _ivColor;
  final VoidCallback _onPressed;
  final bool _isEnabledBool;

  const FirstGenFemaleButton({
    required Color ivColor,
    required void Function() onPressed,
    required bool isEnabledBool,
    Key? key,
  })  : _ivColor = ivColor,
        _onPressed = onPressed,
        _isEnabledBool = isEnabledBool,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 65,
            width: 95,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _isEnabledBool ? _onPressed : null,
                  child: Opacity(
                    opacity: _isEnabledBool ? 1.0 : 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(child: Container(color: _ivColor)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 120,
            width: 50,
            child: CustomPaint(
              size: const Size(50, 300),
              painter: FemaleBranchLinePainter(),
            ),
          ),
        ],
      ),
    );
  }
}
