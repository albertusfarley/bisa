import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/widgets/custom_text.dart';

class DistanceText extends StatelessWidget {
  final Map target;
  final double size;
  final Color color;

  DistanceText(
      {required this.target, this.size = 14, this.color = darkGrey, Key? key})
      : super(key: key);

  MyController myController = Get.find<MyController>();

  @override
  Widget build(BuildContext context) {
    if (myController.myPosition.value == null) return const SizedBox.shrink();

    double distance = myController.calculateDistance(
        myPosition: myController.myPosition.value!, targetPosition: target);

    return RichText(
        text: TextSpan(
            style: GoogleFonts.lexendDeca(color: color, fontSize: size),
            children: [
          const TextSpan(text: ' · '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              Icons.drive_eta_rounded,
              color: darkGrey,
              size: size + 2,
            ),
          ),
          TextSpan(text: ' ${distance.toPrecision(1)} km')
        ]));
  }
}
