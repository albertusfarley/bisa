import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/widgets/custom_text.dart';

class DistanceText extends StatelessWidget {
  Map mine;
  Map target;

  DistanceText({required this.mine, required this.target, Key? key})
      : super(key: key);

  MyController myController = MyController();

  @override
  Widget build(BuildContext context) {
    double distance = myController.calculateDistance(
        myPosition: mine, targetPosition: target);

    return customText(text: '${distance.toPrecision(1)} km', color: darkGrey);
  }
}
