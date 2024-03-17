import 'dart:ui';

import 'package:aquaponia/Home/home_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarChart extends GetView<HomeController> {
  const BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => LineChart(
            LineChartData(
              minY: 0,
              maxY: 14,
              borderData: FlBorderData(
                  border: const Border(
                      top: BorderSide.none,
                      left: BorderSide(width: 1, color: Colors.black54),
                      bottom: BorderSide(width: 1, color: Colors.black54))),
              gridData: const FlGridData(
                  horizontalInterval: 1.25,
                  show: true,
                  drawVerticalLine: true,
                  drawHorizontalLine: true),
              titlesData: const FlTitlesData(
                  topTitles: AxisTitles(drawBelowEverything: false),
                  bottomTitles: AxisTitles(drawBelowEverything: false),
                  rightTitles: AxisTitles(drawBelowEverything: true),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          reservedSize: 25, interval: 2, showTitles: true),
                      axisNameSize: 14,
                      drawBelowEverything: true)),
              lineBarsData: [
                LineChartBarData(
                  color: const Color.fromARGB(255, 40, 62, 2),
                  spots: controller.phLevelController.flSpots.value!,
                  isCurved: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
