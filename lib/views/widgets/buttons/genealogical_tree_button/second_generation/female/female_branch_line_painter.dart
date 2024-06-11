import 'package:flutter/cupertino.dart';

class FemaleBranchLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintStroke = Paint()
      ..color = const Color(0xFF0A0807)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    final Path paintPath = Path()
      ..moveTo(size.width * 0.02, size.height * 0.5)
      ..lineTo(size.width * 0.25, size.height * 0.5)
      ..lineTo(size.width * 0.25, size.height * 0.9)
      ..lineTo(size.width * 0.50, size.height * 0.9);

    canvas.drawPath(paintPath, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
