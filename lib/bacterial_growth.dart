import 'dart:math';

import 'package:bacterial_growth/bacteria.dart';
import 'package:bacterial_growth/bacterial_painter.dart';
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
    return Stack(children: _getBacteria());
  }

  void _tick() {
    if (size == null) {
      Future.delayed(const Duration(milliseconds: 30), _tick);
      return;
    }

    if (bacteriaList.isEmpty) {
      final List<Bacteria> newList = <Bacteria>[];
      newList.add(Bacteria.createRandomFromBounds(size.width, size.height));

      setState(() {
        bacteriaList = newList;
      });
    }

    final List<Bacteria> newList = <Bacteria>[];

    for (final Bacteria bacteria in bacteriaList) {
      final Bacteria newBacteria =
          Bacteria.createRandomFromExistingBacteria(size, bacteria);

      newList.add(newBacteria);

      final bool shouldCreateNew = Random().nextDouble() > 0.995;

      if (shouldCreateNew && bacteriaList.length < 256) {
        newList.add(Bacteria.createRandomFromExistingBacteria(size, bacteria));
      }
    }

    setState(() {
      bacteriaList = newList;
    });

    Future.delayed(const Duration(milliseconds: 30), _tick);
  }

  List<Widget> _getBacteria() {
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
          )
          /*child: Container(
            width: 8,
            height: 8,
            decoration: new BoxDecoration(
              color: Color.fromRGBO(255, 220, 220, 1),//Colors.red.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Color.fromRGBO(255, 180, 180, 1))
            ),
          )*/
          ,
        ),
      );
    }

    return list;
  }
}
