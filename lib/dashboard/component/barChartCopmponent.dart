import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:realopt/dashboard/config/responsive.dart';
import 'package:realopt/dashboard/style/colors.dart';


class BarChartCopmponent extends StatelessWidget {
  const BarChartCopmponent({
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