import 'package:breeder/views/widgets/buttons/genealogical_tree_button/female_branch_line_painter.dart';
import 'package:flutter/material.dart';

class ThirdGenerationFemaleButton extends StatelessWidget {
  final Color leftColor;
  final Color middleColor;
  final Color rightColor;
  final VoidCallback onPressed;

  const ThirdGenerationFemaleButton({
    required this.leftColor,
    required this.middleColor,
    required this.rightColor,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      // width: 150,
      child: Row(
        children: <Widget>[
          _buildButton(),
          _buildCustomPaint(),
        ],
      ),
    );
  }
  Widget _buildButton() {
    return SizedBox(
      height: 65,
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Row(
              children: <Widget>[
                Expanded(child: Container(color: leftColor)),
                Expanded(child: Container(color: middleColor)),
                Expanded(child: Container(color: rightColor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomPaint() {
    return SizedBox(
      height: 400,
      child: CustomPaint(
        size: const Size(75, 400),
        painter: FemaleBranchLinePainter(),
      ),
    );
  }
}
