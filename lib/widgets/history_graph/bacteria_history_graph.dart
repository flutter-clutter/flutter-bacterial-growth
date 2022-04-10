import 'package:bacterial_growth/widgets/history_graph/history_graph_canvas.dart';
import 'package:flutter/material.dart';

class BacteriaHistoryGraph extends StatelessWidget {
  const BacteriaHistoryGraph({
    required this.historyElements,
    required this.currentTick,
    required this.currentBacteriaAmount,
  });

  static const double opacity = 0.5;
  static const double padding = 32;

  final List<BacteriaGrowthHistoryElement> historyElements;
  final int currentTick;
  final int currentBacteriaAmount;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
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
            child: _buildMainPart(constraints),
          ),
        );
      },
    );
  }

  Widget _buildMainPart(BoxConstraints constraints) {
    if (historyElements.isEmpty) return Container();

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        HistoryGraphCanvas(
          historyElements: historyElements,
          currentTick: currentTick,
          currentBacteriaAmount: currentBacteriaAmount,
        ),
        _buildInfoText()
      ],
    );
  }

  Positioned _buildInfoText() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white70,
        child: Text(
          '${historyElements.last.amountOfBacteria} Bacteria',
        ),
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
