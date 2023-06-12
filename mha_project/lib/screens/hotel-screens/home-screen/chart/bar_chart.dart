import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/chart/bar_graph.dart';

class MyBarChart extends StatelessWidget {
  MyBarChart({super.key});

  List<double> weeklyRevenue = [
    16.30,
    30.25,
    22.75,
    13.60,
    29.25,
    45.50,
    24.40,
  ];

  @override
  Widget build(BuildContext context) {
    return MyBarGraph(
      weeklyRevenue: weeklyRevenue,
    );
  }
}
