import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/bar_data.dart';
import 'package:parkir/models/data.dart';
import 'package:parkir/widgets/bar_titles.dart';
import 'package:parkir/widgets/custom_text.dart';

class BarChartWidget extends StatelessWidget {
  List<Data>? data;
  final double height;
  final double barWidth;

  BarChartWidget(
      {required this.data, required this.height, this.barWidth = 12, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNull = (data == null || data!.isEmpty);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: height,
      child: isNull
          ? Center(
              child: customText(text: 'No Data', color: grey),
            )
          : BarChart(BarChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                  border:
                      Border(bottom: BorderSide(width: 1, color: lightGrey))),
              alignment: BarChartAlignment.spaceBetween,
              maxY: 100,
              minY: 0,
              // groupsSpace: 12,
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                bottomTitles: BarTitles.getBottomTitles(data: data ?? []),
                topTitles: BarTitles.hideTitles(),
                rightTitles: BarTitles.hideTitles(),
                leftTitles: BarTitles.hideTitles(),
              ),
              barGroups: data!
                  .map((data) => BarChartGroupData(x: data.id, barRods: [
                        BarChartRodData(
                            y: data.y,
                            width: barWidth,
                            colors: [data.color],
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(8))),
                      ]))
                  .toList())),
    );
  }
}
