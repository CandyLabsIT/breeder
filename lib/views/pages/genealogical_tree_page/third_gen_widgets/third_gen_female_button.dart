import 'package:breeder/views/widgets/genealogical_tree/branch_lines/female_branch_line_painter.dart';
import 'package:flutter/material.dart';

class ThirdGenFemaleButton extends StatelessWidget {
  final Color _leftColor;
  final Color _middleColor;
  final Color _rightColor;
  final VoidCallback _onPressed;
  final bool _isEnabledBool;

  const ThirdGenFemaleButton({
    required Color leftColor,
    required Color middleColor,
    required Color rightColor,
    required void Function() onPressed,
    required bool isEnabledBool,
    Key? key,
  })  : _leftColor = leftColor,
        _middleColor = middleColor,
        _rightColor = rightColor,
        _onPressed = onPressed,
        _isEnabledBool = isEnabledBool,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 65,
            width: 95,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _onPressed,
                  child: Opacity(
                    opacity: _isEnabledBool ? 1.0 : 0.4,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Container(color: _leftColor)),
                        Expanded(child: Container(color: _middleColor)),
                        Expanded(child: Container(color: _rightColor)),
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
              size: const Size(50, 120),
              painter: FemaleBranchLinePainter(),
            ),
          ),
        ],
      ),
    );
  }
}
