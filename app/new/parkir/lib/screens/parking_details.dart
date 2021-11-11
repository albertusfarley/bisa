import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/models/bar_data.dart';
import 'package:parkir/models/parking.dart';
import 'package:parkir/models/parking_name.dart';
import 'package:parkir/screens/posts.dart';
import 'package:parkir/screens/rate_screen.dart';
import 'package:parkir/screens/reviews.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/services/map_utils.dart';
import 'package:parkir/services/time_utils.dart';
import 'package:parkir/services/tools.dart';
import 'package:parkir/widgets/ask_rate.dart';
import 'package:parkir/widgets/avatar.dart';
import 'package:parkir/widgets/bar_chart_widget.dart';
import 'package:parkir/widgets/chart_page.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/distance_text.dart';
import 'package:parkir/widgets/is_open.dart';
import 'package:parkir/widgets/loading.dart';
import 'package:parkir/widgets/photos_view.dart';
import 'package:parkir/widgets/rates.dart';
import 'package:parkir/widgets/rounded_button.dart';
import 'package:parkir/widgets/star_bar.dart';
import 'package:parkir/widgets/tile_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ParkingDetails extends StatefulWidget {
  final String id;

  const ParkingDetails({required this.id, Key? key}) : super(key: key);

  @override
  _ParkingDetailsState createState() => _ParkingDetailsState();
}

class _ParkingDetailsState extends State<ParkingDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MyController myController = Get.find<MyController>();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService().getLocationStream(widget.id),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                constraints: const BoxConstraints.expand(),
                child: const Loading(),
              ),
            );
          }

          Parking parking = Parking(parking: snapshot.data!.data() as Map);
          bool rated = Tools.totalReviews(rates: parking.rates) > 0;

          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              body: Container(
                  constraints: BoxConstraints.expand(),
                  child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverToBoxAdapter(
                              child: Stack(
                            children: [
                              PhotosView(
                                photos: parking.photos,
                              ),
                              Positioned(
                                top: 20,
                                left: horizontalItemPadding,
                                child: ClipOval(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: IconButton(
                                        onPressed: () => Get.back(),
                                        icon: Icon(Icons.arrow_back, size: 20)),
                                  ),
                                ),
                              )
                            ],
                          )),
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ParkingName(raw: parking.name).widget(
                                          size: 20, weight: FontWeight.w900),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          StarBar(rate: parking.rate, size: 16),
                                          customText(
                                              text:
                                                  ' (${Tools.totalReviews(rates: parking.rates)})',
                                              color: darkGrey)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          customText(
                                              text: parking.category,
                                              color: darkGrey),
                                          Row(
                                            children: [
                                              customText(text: ' · '),
                                              const Icon(
                                                Icons.drive_eta_rounded,
                                                color: darkGrey,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          customText(text: ' '),
                                          Obx(() {
                                            Map? myPosition =
                                                myController.myPosition.value;

                                            return myPosition == null
                                                ? SizedBox.shrink()
                                                : DistanceText(
                                                    mine: myPosition,
                                                    target:
                                                        parking.coordinates);
                                          }),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          IsOpen(
                                              hours: parking.hours,
                                              days: parking.days),
                                          customText(
                                              text: ' · ', color: darkGrey),
                                          customText(
                                              text:
                                                  '${TimeUtils.to12HourClock(parking.hours['open'])} - ${TimeUtils.to12HourClock(parking.hours['closed'])}',
                                              color: darkGrey)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          RoundedButton(
                                            iconData: Ionicons.eye_outline,
                                            text: 'View',
                                            active: true,
                                            onPressed: () {},
                                          ),
                                          RoundedButton(
                                            iconData: Ionicons.navigate_outline,
                                            text: 'Direction',
                                            onPressed: () =>
                                                MapUtils.openMap(parking.map),
                                          ),
                                          RoundedButton(
                                            iconData: Ionicons.call_outline,
                                            text: 'Call',
                                            onPressed: () =>
                                                launch('tel:${parking.call}'),
                                          ),
                                          RoundedButton(
                                            iconData: Ionicons.globe_outline,
                                            text: 'Website',
                                            onPressed: () =>
                                                launch(parking.url),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ];
                      },
                      body: Column(
                        children: [
                          verticalItemSpacer(half: true),
                          Container(
                            width: Get.width,
                            child: TabBar(
                              controller: _tabController,
                              labelColor: primary,
                              indicatorColor: primary,
                              unselectedLabelColor: grey,
                              tabs: const [
                                Tab(
                                  text: 'Overview',
                                ),
                                Tab(
                                  text: 'Reviews',
                                ),
                                Tab(
                                  text: 'Posts',
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Container(
                                    child: ListView(children: [
                                      verticalItemSpacer(half: true),
                                      TileButton(
                                          iconData: Ionicons.navigate,
                                          text: parking.address,
                                          onPressed: () =>
                                              MapUtils.openMap(parking.map)),
                                      TileButton(
                                          iconData: Ionicons.call,
                                          text: parking.call,
                                          onPressed: () => launch(parking.url)),
                                      TileButton(
                                          iconData: Ionicons.globe,
                                          text: parking.url,
                                          onPressed: () => launch(parking.url)),
                                      verticalSpacer(),
                                      ChartPage(popular: parking.times),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 24, horizontal: 24),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                customText(
                                                    text: 'Ratings & Reviews',
                                                    weight: FontWeight.bold),
                                                rated
                                                    ? TextButton(
                                                        onPressed: () =>
                                                            _tabController
                                                                .animateTo(1),
                                                        child: customText(
                                                            text: 'See all',
                                                            color: grey,
                                                            size: 12))
                                                    : customText(
                                                        text: 'Tap to rate',
                                                        color: grey,
                                                        size: 12)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                verticalItemSpacer(),
                                                rated
                                                    ? Rates(
                                                        rates: parking.rates,
                                                      )
                                                    : AskRate(
                                                        id: parking.id,
                                                        name: parking.name,
                                                        rates: parking.rates),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      verticalItemSpacer()
                                    ]),
                                  ),
                                  Reviews(
                                      id: parking.id,
                                      name: parking.name,
                                      rates: parking.rates),
                                  Posts(
                                      id: parking.id,
                                      name: parking.name,
                                      thumbnail: parking.thumbnail)
                                  // ListView(
                                  //   shrinkWrap: true,
                                  //   physics: const ClampingScrollPhysics(),
                                  //   children: [
                                  //     for (String photo in parking.photos)
                                  //       Container(
                                  //         padding:
                                  //             const EdgeInsets.only(bottom: 8),
                                  //         child: Image.network(
                                  //           photo,
                                  //           fit: BoxFit.contain,
                                  //         ),
                                  //       )
                                  //   ],
                                  // ),
                                ]),
                          )
                        ],
                      ))),
            ),
          );
        });
  }
}
