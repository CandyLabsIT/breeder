import 'package:breeder/views/widgets/genealogical_tree/branch_lines/female_branch_line_painter.dart';
import 'package:flutter/material.dart';

class FirstGenFemaleButton extends StatelessWidget {
  final Color ivColor;
  final VoidCallback onPressed;
  final bool isEnabled;

  const FirstGenFemaleButton({
    required this.ivColor,
    required this.onPressed,
    required this.isEnabled,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 250,
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 65,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: isEnabled ? onPressed : null,
                  child: Opacity(
                    opacity: isEnabled ? 1.0 : 0.5,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Container(color: ivColor)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: 150,
            child: CustomPaint(
              size: const Size(400, 400),
              painter: FemaleBranchLinePainter(),
            ),
          ),
        ],
      ),
    );
  }
}
