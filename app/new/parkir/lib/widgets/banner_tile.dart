import 'package:flutter/material.dart';
import 'package:parkir/models/my_banner.dart';

class BannerTile extends StatelessWidget {
  final MyBanner banner;

  const BannerTile({required this.banner, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      margin: const EdgeInsets.all(4),
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
