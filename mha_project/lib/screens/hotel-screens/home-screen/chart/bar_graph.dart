import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mha_project/screens/hotel-screens/home-screen/chart/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  const MyBarGraph(
      {super.key, required this.weeklyRevenue, required this.highestValue});

  final List weeklyRevenue;
  final double highestValue;

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
      maxY: highestValue,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ), // hide top titles
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTiles,
          ),
        ),
      ),
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
                    toY: highestValue,
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

Widget getBottomTiles(double value, TitleMeta meta) {
  const style = TextStyle(
      // color: Colors.grey,
      // fontWeight: FontWeight.bold,
      // fontSize: 14,
      );

  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Mo', style: style);
      break;
    case 2:
      text = const Text('Tu', style: style);
      break;
    case 3:
      text = const Text('We', style: style);
      break;
    case 4:
      text = const Text('Th', style: style);
      break;
    case 5:
      text = const Text('Fr', style: style);
      break;
    case 6:
      text = const Text('Sa', style: style);
      break;
    case 7:
      text = const Text('Su', style: style);
      break;
    default:
      text = const Text('Null', style: style);
      break;
  }
  return text;
}
