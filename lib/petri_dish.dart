import 'dart:async';
import 'dart:math';

import 'package:bacterial_growth/model/bacteria.dart';
import 'package:bacterial_growth/widgets/bacteria_collection/bacteria_collection_canvas.dart';
import 'package:bacterial_growth/widgets/history_graph/bacteria_growth_history_element.dart';
import 'package:bacterial_growth/widgets/history_graph/bacteria_history_graph.dart';
import 'package:flutter/material.dart';

class PetriDish extends StatefulWidget {
  const PetriDish({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PetriDishState();
  }
}

class _PetriDishState<PetriDish> extends State {
  static const int tickTime = 30;
  static const double recreationProbability = 0.005;
  static const double deathProbability = 0.001;
  static const double maxBacteriaAmount = 1024;

  int currentTick = 0;
  List<Bacteria> bacteriaList = <Bacteria>[];
  List<BacteriaGrowthHistoryElement> bacteriaGrowthHistory =
      <BacteriaGrowthHistoryElement>[];
  Size size = Size.zero;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: tickTime), (timer) {
      _tick();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        size = constraints.biggest;
        return Stack(
          children: <Widget>[
            SizedBox(
              width: size.width,
              height: size.height,
              child: BacteriaCollectionCanvas(bacteriaList: bacteriaList),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: constraints.maxWidth,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 32,
                    left: 16,
                    right: 16,
                  ),
                  child: BacteriaHistoryGraph(
                    currentBacteriaAmount: bacteriaList.length,
                    currentTick: currentTick,
                    historyElements: bacteriaGrowthHistory,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _tick() {
    currentTick += 1;

    if (bacteriaList.isEmpty) {
      _createInitialBacteria();
      return;
    }

    _iterateAllBacteria();
  }

  void _createInitialBacteria() {
    final List<Bacteria> newList = <Bacteria>[];
    newList.add(Bacteria.createRandomFromBounds(size.width, size.height));

    _updateBacteriaList(newList);
  }

  void _iterateAllBacteria() {
    final List<Bacteria> newList = <Bacteria>[];

    for (final Bacteria bacteria in bacteriaList) {
      final bool shouldDie = Random().nextDouble() > 1 - deathProbability;

      if (!shouldDie) {
        final Bacteria movedBacteria =
            Bacteria.createRandomFromExistingBacteria(
          size,
          bacteria,
        );
        newList.add(movedBacteria);
      }

      _createNewBacteria(bacteria, newList);
    }

    _updateBacteriaList(newList);
  }

  void _createNewBacteria(Bacteria bacteria, List<Bacteria> newList) {
    final bool shouldCreateNew =
        Random().nextDouble() > 1 - recreationProbability;

    if (shouldCreateNew && bacteriaList.length < maxBacteriaAmount) {
      newList.add(
        Bacteria.createRandomFromExistingBacteria(size, bacteria),
      );
    }
  }

  void _updateBacteriaList(List<Bacteria> newList) {
    setState(() {
      bacteriaList = newList;
      bacteriaGrowthHistory.add(
        BacteriaGrowthHistoryElement(
          tickNumber: currentTick,
          amountOfBacteria: newList.length,
        ),
      );
    });
  }
}
