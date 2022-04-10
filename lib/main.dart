import 'package:bacterial_growth/petri_dish.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BacterialGrowthApp());
}

class BacterialGrowthApp extends StatelessWidget {
  const BacterialGrowthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      title: 'Flutter Clutter Bacterial Growth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        backgroundColor: Colors.white,
        body: PetriDish(),
      ),
    );
  }
}
