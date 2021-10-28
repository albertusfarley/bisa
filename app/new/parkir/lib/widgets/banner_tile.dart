import 'package:flutter/material.dart';
import 'package:parkir/models/my_banner.dart';

class BannerTile extends StatelessWidget {
  final MyBanner banner;

  const BannerTile({required this.banner, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('bannerURL = ${banner.imageURL}');

    return Container(
      // constraints: const BoxConstraints.expand(),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.black,
      ),
      margin: EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          banner.imageURL,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
