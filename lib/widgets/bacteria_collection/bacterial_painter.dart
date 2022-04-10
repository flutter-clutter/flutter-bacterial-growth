import 'package:flutter/material.dart';

class BacteriaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final Rect rect = Rect.fromLTWH(0, 0, size.width / 2, size.height);
    final RRect rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(size.width / 2),
    );
    paint.strokeWidth = 2;
    paint.color = const Color.fromRGBO(255, 150, 150, 0.6);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
