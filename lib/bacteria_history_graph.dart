import 'dart:math';

import 'package:flutter/material.dart';

class BacteriaHistoryGraph extends StatelessWidget {
  const BacteriaHistoryGraph({
    required this.historyElements,
    required this.currentTick,
    required this.currentBacteriaAmount,
  });

  static const double padding = 32;
  static const double opacity = 0.5;
  static const int elementDrawLimit = 2000;

  final List<BacteriaGrowthHistoryElement> historyElements;
  final int currentTick;
  final int currentBacteriaAmount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double dotSize = constraints.maxWidth / 120;
        final double width =
            constraints.maxWidth - (padding * 2) - (dotSize * 2);
        final double height =
            constraints.maxHeight - (padding * 2) - (dotSize * 2);

        return Opacity(
          opacity: opacity,
          child: Container(
            padding: const EdgeInsets.all(
              padding,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                )
              ],
            ),
            child: _buildStack(dotSize, width, height),
          ),
        );
      },
    );
  }

  Widget _buildStack(double dotSize, double width, double height) {
    if (historyElements.isEmpty || currentBacteriaAmount == 0) {
      return Container();
    }
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

class BacteriaGrowthHistoryElement {
  BacteriaGrowthHistoryElement({
    required this.tickNumber,
    required this.amountOfBacteria,
  });

  final int tickNumber;
  final int amountOfBacteria;
}
