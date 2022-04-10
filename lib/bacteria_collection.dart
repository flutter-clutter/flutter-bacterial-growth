import 'package:bacterial_growth/bacterial_painter.dart';
import 'package:bacterial_growth/model/bacteria.dart';
import 'package:flutter/material.dart';

class BacteriaCollection extends StatelessWidget {
  const BacteriaCollection({required this.bacteriaList});

  final List<Bacteria> bacteriaList;

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = <Widget>[];

    for (final Bacteria bacteria in bacteriaList) {
      list.add(
        Positioned(
          left: bacteria.x,
          top: bacteria.y,
          child: SizedBox(
            width: bacteria.width,
            height: bacteria.height,
            child: Transform.rotate(
              angle: bacteria.rotation,
              child: CustomPaint(
                painter: BacteriaPainter(),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(children: list);
  }
}
