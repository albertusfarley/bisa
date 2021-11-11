import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/my_banner.dart';
import 'package:parkir/widgets/banner_tile.dart';
import 'package:shimmer/shimmer.dart';

class BannerList extends StatefulWidget {
  final List? rawBanners;
  final double initialPadding;

  const BannerList({this.rawBanners, this.initialPadding = 24, Key? key})
      : super(key: key);

  @override
  _BannerListState createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  @override
  Widget build(BuildContext context) {
    CarouselController bannerController = CarouselController();
    List<Widget> banners = [];

    if (widget.rawBanners == null) {
      return Container(
        height: Get.width / 2,
        width: Get.width,
        margin: const EdgeInsets.only(top: 16),
        child: Shimmer.fromColors(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // boxShadow: listShadow,
                color: white,
              ),
            ),
            baseColor: lightGrey,
            highlightColor: Colors.grey[100]!),
      );
    }

    for (var item in widget.rawBanners!) {
      banners.add(BannerTile(
          banner: MyBanner(
              imageURL: item['image_url'], hyperlink: item['hyperlink'])));
    }

    return Container(
      padding: const EdgeInsets.only(top: 16),
      // color: white,
      child: CarouselSlider(
        items: banners,
        carouselController: bannerController,
        options: CarouselOptions(
          disableCenter: false,
          enableInfiniteScroll: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          viewportFraction: 1,
          aspectRatio: 2,
          initialPage: 0,
        ),
      ),
    );
  }
}
