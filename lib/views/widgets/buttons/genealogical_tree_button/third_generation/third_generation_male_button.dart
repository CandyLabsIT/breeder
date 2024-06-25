import 'package:flutter/material.dart';

class ThirdGenerationMaleButton extends StatelessWidget {
  final Color leftColor;
  final Color middleColor;
  final Color rightColor;
  final VoidCallback onPressed;

  const ThirdGenerationMaleButton({
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
      width: 250,
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
      width: 150,
      child: CustomPaint(
        size: const Size(400, 400),
        painter: MaleBranchLinePainter(),
      ),
    );
  }
}

class MaleBranchLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintStroke = Paint()
      ..color = const Color(0xFF0A0807)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final Path path = Path()
      ..moveTo(size.width * 0.02, size.height * 0.5)
      ..lineTo(size.width * 0.25, size.height * 0.5)
      ..lineTo(size.width * 0.25, size.height * 0.1)
      ..lineTo(size.width * 0.5, size.height * 0.1);

    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
