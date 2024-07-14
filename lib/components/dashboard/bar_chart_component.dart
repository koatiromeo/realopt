import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class BarChartComponent extends StatelessWidget {
  const BarChartComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BarChart(
        BarChartData(
          borderData: FlBorderData(show: false) ,
          alignment: BarChartAlignment.spaceBetween,
          gridData: FlGridData(drawHorizontalLine: true, horizontalInterval: 30),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}