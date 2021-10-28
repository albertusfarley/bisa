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
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      for (var i = 0; i < 5; i++)
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.black,
          ),
          margin: EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              'https://raw.githubusercontent.com/albertusfarley/bisa/main/public/banners/binus_syahdan.jpg',
              fit: BoxFit.cover,
            ),
          ),
        )
    ];

    CarouselController bannerController = CarouselController();

    // return SizedBox(
    //   height: 60,
    //   width: 120,
    // );

    return FutureBuilder(
        future: DatabaseService().getBannersCollection(),
        builder: (_, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List<Widget> banners = [];

            List data = snapshot.data!;
            print('Data = $data');
            data.forEach((item) => banners.add(BannerTile(
                banner: MyBanner(
                    imageURL: item['image_url'],
                    hyperlink: item['hyperlink']))));

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CarouselSlider(
                    items: banners,
                    carouselController: bannerController,
                    options: CarouselOptions(
                        disableCenter: false,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 8),
                        viewportFraction: .9,
                        aspectRatio: 20 /
                            9, // Maintain AspectRatio with viewPortFraction
                        initialPage: 0,
                        onPageChanged: (_current, _) {
                          setState(() {
                            _index = _current;
                          });
                        }),
                  ),
                ]);
          } else {
            return Container();
          }
        });
  }
}
