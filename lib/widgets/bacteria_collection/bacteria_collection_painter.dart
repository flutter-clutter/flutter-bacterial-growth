import 'package:bacterial_growth/model/bacteria.dart';
import 'package:flutter/material.dart';

class BacteriaCollectionPainter extends CustomPainter {
  const BacteriaCollectionPainter({required this.bacteriaList});

  final List<Bacteria> bacteriaList;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: Rotate
    final Paint paint = Paint();
    for (final Bacteria bacteria in bacteriaList) {
      final Rect rect = Rect.fromLTWH(
        bacteria.x,
        size.height - bacteria.y,
        bacteria.width / 2,
        bacteria.height,
      );
      final RRect roundedRectangle = RRect.fromRectAndRadius(
        rect,
        Radius.circular(bacteria.width / 2),
      );
      paint.strokeWidth = 2;
      paint.color = const Color.fromRGBO(255, 150, 150, 0.6);

      canvas.drawRRect(roundedRectangle, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
