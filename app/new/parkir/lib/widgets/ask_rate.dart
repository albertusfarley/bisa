import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/screens/rate_screen.dart';
import 'package:parkir/services/tools.dart';
import 'package:parkir/widgets/avatar.dart';
import 'package:parkir/widgets/star_bar.dart';

class AskRate extends StatelessWidget {
  final String id;
  final String name;
  final Map rates;
  const AskRate(
      {required this.id, required this.name, required this.rates, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration:
          BoxDecoration(color: light, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Avatar(),
          horizontalItemSpacer(),
          StarBar(
              rate: 0,
              size: 32,
              spacing: Get.width / 64,
              onUpdate: (rate) {
                Get.to(
                    () => RateScreen(
                        id: id,
                        name: name,
                        currentRate: Tools.ratesAverage(rates: rates),
                        rates: rates,
                        rate: rate),
                    transition: Transition.downToUp);
              }),
        ],
      ),
    );
  }
}
