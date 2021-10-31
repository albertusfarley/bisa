import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/my_banner.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/banner_tile.dart';
import 'package:parkir/widgets/loading.dart';

class BannerList extends StatefulWidget {
  final double initialPadding;

  const BannerList({this.initialPadding = 24, Key? key}) : super(key: key);

  @override
  _BannerListState createState() => _BannerListState();
}

class _BannerListState extends State<BannerList> {
  @override
  Widget build(BuildContext context) {
    CarouselController bannerController = CarouselController();
    return FutureBuilder(
        future: DatabaseService().getBannersCollection(),
        builder: (_, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List<Widget> banners = [];

            List data = snapshot.data!;
            for (var item in data) {
              banners.add(BannerTile(
                  banner: MyBanner(
                      imageURL: item['image_url'],
                      hyperlink: item['hyperlink'])));
            }

            return CarouselSlider(
              items: banners,
              carouselController: bannerController,
              options: CarouselOptions(
                disableCenter: false,
                enableInfiniteScroll: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                viewportFraction: .9,
                aspectRatio: 2 / .9,
                initialPage: 0,
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
