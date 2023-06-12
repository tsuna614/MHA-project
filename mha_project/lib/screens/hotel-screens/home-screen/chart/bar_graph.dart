import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/chart/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph({super.key, required this.weeklyRevenue});

  final List weeklyRevenue;

  @override
  Widget build(BuildContext context) {
    // initialize bar data
    BarData data = BarData(
      sunAmount: weeklyRevenue[0],
      monAmount: weeklyRevenue[1],
      tueAmount: weeklyRevenue[2],
      wedAmount: weeklyRevenue[3],
      thuAmount: weeklyRevenue[4],
      friAmount: weeklyRevenue[5],
      satAmount: weeklyRevenue[6],
    );
    data.initializeBarData();
    return BarChart(BarChartData(
      maxY: 50,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: data.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5),
                  width: 30,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 50,
                    color: Colors.grey.withOpacity(0.05),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    ));
  }
}
