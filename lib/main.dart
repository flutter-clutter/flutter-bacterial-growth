import 'package:bacterial_growth/bacterial_growth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BacterialGrowthApp());
}

class BacterialGrowthApp extends StatelessWidget {
  const BacterialGrowthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Clutter Bacterial Growth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: PetriDish(),
      ),
    );
  }
}
