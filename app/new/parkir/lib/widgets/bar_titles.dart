import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/bar_data.dart';
import 'package:parkir/models/data.dart';
import 'package:parkir/services/time_utils.dart';

class BarTitles {
  static SideTitles getBottomTitles({required List<Data> data}) {
    return SideTitles(
        interval: 3,
        showTitles: true,
        getTextStyles: (_, value) => TextStyle(color: black, fontSize: 10),
        // margin: 10,
        getTitles: (double id) {
          return TimeUtils.to12HourClock(int.parse(
              data.firstWhere((element) => element.id == id.toInt()).name));
        });
  }

  static SideTitles hideTitles() => SideTitles(showTitles: false);
}
