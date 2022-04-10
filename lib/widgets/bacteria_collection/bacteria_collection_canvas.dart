import 'package:bacterial_growth/model/bacteria.dart';
import 'package:bacterial_growth/widgets/bacteria_collection/bacteria_collection_painter.dart';
import 'package:flutter/material.dart';

class BacteriaCollectionCanvas extends StatelessWidget {
  const BacteriaCollectionCanvas({required this.bacteriaList});

  final List<Bacteria> bacteriaList;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BacteriaCollectionPainter(bacteriaList: bacteriaList),
    );
  }
}
