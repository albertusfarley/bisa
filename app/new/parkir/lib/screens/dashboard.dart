import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/my_banner.dart';
import 'package:parkir/routes/route_name.dart';
import 'package:parkir/screens/dashboard_shimmer.dart';
import 'package:parkir/screens/search_area.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/avatar.dart';
import 'package:parkir/widgets/loading.dart';
import 'package:parkir/widgets/parking_list.dart';
import 'package:parkir/widgets/parking_tile.dart';
import 'package:parkir/widgets/banner_list.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/new_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchController = TextEditingController();

  AuthController _auth = Get.find();
  DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: light,
        constraints: const BoxConstraints.expand(),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 16),
              width: Get.width,
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          text: 'Hi, ${_auth.user!.name!}!', color: grey),
                      const SizedBox(
                        height: 4,
                      ),
                      customText(
                        text: 'Find your parking space.',
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () => Get.to(() => const SearchArea()),
                          icon: const Icon(
                            Ionicons.search,
                            color: dark,
                            size: 20,
                          )),
                      const SizedBox(
                        width: 8,
                      ),
                      const Avatar()
                    ],
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: _db.getBannersCollection(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  List? rawBanners = snapshot.data;
                  return BannerList(
                    rawBanners: rawBanners,
                  );
                }),
            StreamBuilder<QuerySnapshot>(
                stream: _db.getLocationsStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return DashboardShimmer();

                  List rawLocations =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: horizontalPadding,
                            right: horizontalPadding,
                            bottom: 16,
                            top: 8),
                        child: RichText(
                          text: TextSpan(
                              style: GoogleFonts.lexendDeca(
                                  color: black, fontWeight: FontWeight.bold),
                              children: const [
                                TextSpan(text: 'Our suggestions for you '),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.local_fire_department_rounded,
                                  color: Colors.red,
                                  size: 16,
                                ))
                              ]),
                        ),
                      ),
                      NewList(
                        locations: rawLocations,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding, vertical: 16),
                        child: RichText(
                          text: TextSpan(
                              style: GoogleFonts.lexendDeca(
                                  color: black, fontWeight: FontWeight.bold),
                              children: const [
                                TextSpan(text: 'Parking locations for you '),
                                WidgetSpan(
                                    child: Icon(
                                  Icons.star_rounded,
                                  color: Colors.orange,
                                  size: 16,
                                ))
                              ]),
                        ),
                      ),
                      ParkingList(
                        locations: rawLocations,
                      ),
                      verticalItemSpacer(),
                    ],
                  );
                })
          ],
        ));
  }
}
