import 'package:bacterial_growth/model/bacteria.dart';
import 'package:flutter/material.dart';

class BacteriaCollectionPainter extends CustomPainter {
  const BacteriaCollectionPainter({required this.bacteriaList});

  final List<Bacteria> bacteriaList;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    for (final Bacteria bacteria in bacteriaList) {
      final Rect rect = Rect.fromLTWH(
        bacteria.x,
        bacteria.y,
        bacteria.width,
        bacteria.height,
      );
      final RRect roundedRectangle = RRect.fromRectAndRadius(
        rect,
        Radius.circular(bacteria.width / 2),
      );
      paint.strokeWidth = 2;
      paint.color = Colors.black38;

      _drawRotated(
        canvas,
        Offset(
          bacteria.x + (bacteria.width / 2),
          bacteria.y + (bacteria.height / 2),
        ),
        bacteria.rotation,
        () => canvas.drawRRect(roundedRectangle, paint),
      );
    }
  }

  void _drawRotated(
    Canvas canvas,
    Offset center,
    double angle,
    VoidCallback drawFunction,
  ) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);
    drawFunction();
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
