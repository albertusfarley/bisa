import 'package:flutter/material.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/location.dart';
import 'package:parkir/models/parking_area.dart';
import 'package:parkir/widgets/custom_text.dart';

class AreaTile extends StatelessWidget {
  final Location location;

  const AreaTile({required this.location, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = 80;

    return Container(
      height: height,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              location.thumbnail,
              fit: BoxFit.cover,
              height: height,
              width: height,
            ),
          ),
          horizontalSpacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customText(text: location.name, weight: FontWeight.bold),
              customText(text: location.category)
            ],
          )
        ],
      ),
    );
  }
}
