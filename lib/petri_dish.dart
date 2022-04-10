import 'dart:math';

import 'package:bacterial_growth/bacteria_collection.dart';
import 'package:bacterial_growth/model/bacteria.dart';
import 'package:flutter/material.dart';

// TODO: Add graph symbolizing the growth

class PetriDish extends StatefulWidget {
  const PetriDish({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PetriDishState();
  }
}

class _PetriDishState<PetriDish> extends State {
  static const int tickTime = 30;
  static const double recreationProbability = 0.995;
  static const double maxBacteriaAmount = 256;

  List<Bacteria> bacteriaList = <Bacteria>[];
  late Size size;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), _tick);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BacteriaCollection(bacteriaList: bacteriaList);
  }

  void _tick() {
    if (size == null) {
      _nextTick();
      return;
    }

    if (bacteriaList.isEmpty) {
      _createInitialBacteria();
      _nextTick();
      return;
    }

    _createNewRandomBacteria();

    _nextTick();
  }

  void _nextTick() {
    Future.delayed(const Duration(milliseconds: tickTime), _tick);
  }

  void _createInitialBacteria() {
    final List<Bacteria> newList = <Bacteria>[];
    newList.add(Bacteria.createRandomFromBounds(size.width, size.height));

    setState(() {
      bacteriaList = newList;
    });
  }

  void _createNewRandomBacteria() {
    final List<Bacteria> newList = <Bacteria>[];

    for (final Bacteria bacteria in bacteriaList) {
      final Bacteria newBacteria = Bacteria.createRandomFromExistingBacteria(
        size,
        bacteria,
      );

      newList.add(newBacteria);

      final bool shouldCreateNew =
          Random().nextDouble() > recreationProbability;

      if (shouldCreateNew && bacteriaList.length < maxBacteriaAmount) {
        newList.add(
          Bacteria.createRandomFromExistingBacteria(size, bacteria),
        );
      }
    }

    setState(() {
      bacteriaList = newList;
    });
  }
}
