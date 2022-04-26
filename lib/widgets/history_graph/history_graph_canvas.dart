import 'package:bacterial_growth/widgets/history_graph/bacteria_growth_chart_painter.dart';
import 'package:bacterial_growth/widgets/history_graph/bacteria_growth_history_element.dart';
import 'package:flutter/material.dart';

class HistoryGraphCanvas extends StatelessWidget {
  const HistoryGraphCanvas({
    required this.historyElements,
    required this.currentTick,
    required this.currentBacteriaAmount,
  });

  final List<BacteriaGrowthHistoryElement> historyElements;
  final int currentTick;
  final int currentBacteriaAmount;

  @override
  Widget build(BuildContext context) {
    if (historyElements.isEmpty || currentBacteriaAmount == 0) {
      return Container();
    }
    return CustomPaint(
      painter: BacteriaGrowthChartPainter(
        historyElements: historyElements,
        currentTick: currentTick,
        currentBacteriaAmount: currentBacteriaAmount,
      ),
    );
  }
}
