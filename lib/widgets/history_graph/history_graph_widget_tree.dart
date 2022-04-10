import 'dart:math';

import 'package:bacterial_growth/widgets/history_graph/bacteria_history_graph.dart';
import 'package:flutter/material.dart';

class HistoryGraphWidgetTree extends StatelessWidget {
  const HistoryGraphWidgetTree({
    required this.historyElements,
    required this.currentTick,
    required this.currentBacteriaAmount,
    required this.size,
  });

  static const int elementDrawLimit = 2000;
  static const double padding = 32;

  final List<BacteriaGrowthHistoryElement> historyElements;
  final int currentTick;
  final int currentBacteriaAmount;
  final Size size;

  @override
  Widget build(BuildContext context) {
    if (historyElements.isEmpty || currentBacteriaAmount == 0) {
      return Container();
    }

    final double dotSize = size.height / 120;
    final double width = size.width - (padding * 2) - (dotSize * 2);
    final double height = size.height - (padding * 2) - (dotSize * 2);

    final List<BacteriaGrowthHistoryElement> limitedElements =
        historyElements.sublist(
      max(0, historyElements.length - elementDrawLimit),
    );
    return Stack(
      children: <Widget>[
        for (BacteriaGrowthHistoryElement element in limitedElements)
          _buildGraphPoint(dotSize, element, limitedElements, width, height)
      ],
    );
  }

  Widget _buildGraphPoint(
    double dotSize,
    BacteriaGrowthHistoryElement element,
    List<BacteriaGrowthHistoryElement> elements,
    double width,
    double height,
  ) {
    return Positioned(
      left: dotSize +
          (((element.tickNumber - elements.first.tickNumber) /
                  (currentTick - elements.first.tickNumber)) *
              width),
      bottom: dotSize +
          ((element.amountOfBacteria / currentBacteriaAmount) * height),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        width: dotSize,
        height: dotSize,
      ),
    );
  }
}
