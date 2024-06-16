import 'package:flutter/material.dart';
import 'package:realopt/dashboard/component/paymentListTile.dart';
import 'package:realopt/dashboard/config/size_config.dart';
import 'package:realopt/dashboard/data.dart';
import 'package:realopt/dashboard/style/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:realopt/dashboard/style/style.dart';

class PaymentDetailList extends StatelessWidget {
  const PaymentDetailList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Added padding to the entire content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 5,
            ),
            SizedBox(
              height: 300, // Set a fixed height for the PieChart
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: PieChart(PieChartData(
                  centerSpaceRadius: 5,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  sections: [
                    PieChartSectionData(value: 35, color: Colors.purple, radius: 100),
                    PieChartSectionData(value: 40, color: Colors.amber, radius: 100),
                    PieChartSectionData(value: 55, color: Colors.green, radius: 100),
                    PieChartSectionData(value: 70, color: Colors.orange, radius: 100),
                  ],
                )),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                    text: 'Recent Activities', size: 18, fontWeight: FontWeight.w800),
                PrimaryText(
                  text: '02 Mar 2021',
                  size: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Column(
              children: List.generate(
                recentActivities.length,
                    (index) => PaymentListTile(
                    icon: recentActivities[index]["icon"],
                    label: recentActivities[index]["label"],
                    amount: recentActivities[index]["amount"]),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 5,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryText(
                    text: 'Upcoming Payments', size: 18, fontWeight: FontWeight.w800),
                PrimaryText(
                  text: '02 Mar 2021',
                  size: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            Column(
              children: List.generate(
                upcomingPayments.length,
                    (index) => PaymentListTile(
                    icon: upcomingPayments[index]["icon"],
                    label: upcomingPayments[index]["label"],
                    amount: upcomingPayments[index]["amount"]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
