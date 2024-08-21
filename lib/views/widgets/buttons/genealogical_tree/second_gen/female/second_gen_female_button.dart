import 'package:breeder/views/widgets/buttons/genealogical_tree/second_gen/female/female_branch_line_painter.dart';
import 'package:flutter/material.dart';

class SecondGenFemaleButton extends StatelessWidget {
  final Color leftColor;
  final Color rightColor;
  final VoidCallback onPressed;
  // final bool isTranslucent;

  const SecondGenFemaleButton({
    required this.leftColor,
    required this.rightColor,
    required this.onPressed,
    // required this.isTranslucent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      // width: 175,
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
                  onTap: onPressed,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          // color: isTranslucent ? leftColor.withOpacity(0.35) : leftColor,
                            color: leftColor
                        ),
                      ),
                      Expanded(
                        child: Container(
                          // color: isTranslucent ? rightColor.withOpacity(0.35) : rightColor,
                            color: rightColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: CustomPaint(
              size: const Size(100, 400),
              painter: FemaleBranchLinePainter(),
            ),
          ),
        ],
      ),
    );
  }
}
