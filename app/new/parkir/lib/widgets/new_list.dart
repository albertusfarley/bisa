import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';

import 'custom_text.dart';

class NewList extends StatelessWidget {
  final double initialPadding;

  const NewList({this.initialPadding = 24, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      for (var i = 0; i < 2; i++)
        Container(
          height: 180,
          width: 140,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  'https://raw.githubusercontent.com/albertusfarley/bisa/main/public/locations/binus_syahdan/assets/thumbnail.jpeg',
                  fit: BoxFit.cover,
                  height: 180,
                  width: 140,
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  height: 32,
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primary.withOpacity(.9)),
                  child: Center(
                    child: customText(
                        text: 'New', weight: FontWeight.bold, color: white),
                  ),
                ),
              )
            ],
          ),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: initialPadding),
          child: customText(text: 'New Area', weight: FontWeight.bold),
        ),
        verticalSpacer(),
        SizedBox(
          height: 200,
          width: Get.width,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Container(
                  padding: EdgeInsets.only(
                      left: index == 0 ? 24 : 0,
                      right: index == items.length - 1 ? 24 : 0),
                  child: items[index]),
              separatorBuilder: (_, index) => horizontalSpacer(),
              itemCount: items.length),
        ),
      ],
    );
  }
}
