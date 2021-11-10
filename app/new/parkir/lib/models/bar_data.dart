import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/data.dart';

class BarData {
  late List<Data> data;

  BarData({required Map raw}) {
    data = [];

    raw.forEach((key, value) => data.add(Data(
        name: key,
        y: value.toDouble(),
        color:
            value == 100 ? Colors.red.withOpacity(.5) : primary.withOpacity(.5),
        id: int.parse(key))));

    data.sort((a, b) => int.parse(a.name).compareTo(int.parse(b.name)));
  }

  static List<Data> randomData(int length) {
    List<Data> data = [];

    for (var i = 0; i < length; i++) {
      data.add(Data(
        id: i,
        name: i.toString(),
        y: Random().nextInt(101).toDouble(),
        color: primary,
      ));
    }

    return data;
  }

  static List<Data> noData(int length) {
    List<Data> data = [];

    for (var i = 0; i < length; i++) {
      data.add(Data(
        id: i,
        name: i.toString(),
        y: 1,
        color: grey,
      ));
    }

    return data;
  }
}
