import 'package:flutter/cupertino.dart';

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
