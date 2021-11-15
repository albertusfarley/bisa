import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/constants/shadow.dart';
import 'package:parkir/models/my_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerTile extends StatelessWidget {
  final MyBanner banner;

  const BannerTile({required this.banner, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launch(banner.hyperlink),
      child: Container(
        width: (Get.width - 64),
        height: (Get.width - 64) / 2,
        decoration: BoxDecoration(
            boxShadow: listShadow, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              banner.imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
