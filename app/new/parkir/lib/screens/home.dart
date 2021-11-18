import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/controllers/ticket_controller.dart';
import 'package:parkir/models/my_banner.dart';
import 'package:parkir/models/ticket.dart';
import 'package:parkir/routes/route_name.dart';
import 'package:parkir/screens/home_shimmer.dart';
import 'package:parkir/screens/search_area.dart';
import 'package:parkir/screens/ticket_screen.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/avatar.dart';
import 'package:parkir/widgets/loading.dart';
import 'package:parkir/widgets/location_list.dart';
import 'package:parkir/widgets/location_tile.dart';
import 'package:parkir/widgets/banner_list.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/new_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();

  final AuthController _auth = Get.find();
  final DatabaseService _db = DatabaseService();
  final TicketController _ticket = Get.find<TicketController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ticket.getTicket();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: white,
      child: SafeArea(
        child: Scaffold(
          body: Container(
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
                            Obx(() {
                              return IconButton(
                                  onPressed: () => Get.to(() => TicketScreen()),
                                  icon: Icon(
                                    Icons.description,
                                    color: _ticket.data.value == null
                                        ? dark
                                        : primary,
                                  ));
                            }),
                            IconButton(
                                onPressed: () {
                                  _ticket.deleteTicket();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: grey,
                                )),
                            // IconButton(
                            //     onPressed: () =>
                            //         Get.to(() => const SearchArea()),
                            //     icon: const Icon(
                            //       Ionicons.search,
                            //       color: dark,
                            //       size: 20,
                            //     )),
                            const SizedBox(
                              width: 8,
                            ),
                            const Avatar()
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  StreamBuilder<DocumentSnapshot>(
                      stream: _db.getBannersStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return BannerList();

                        Map rawBanners =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return BannerList(
                          rawBanners: rawBanners.values.toList()
                            ..sort(
                                (b, a) => a['millis'].compareTo(b['millis'])),
                        );
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _db.getLocationsStream(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return HomeShimmer();

                        List rawLocations = snapshot.data!.docs
                            .map((doc) => doc.data())
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: horizontalPadding,
                                right: horizontalPadding,
                              ),
                              child: RichText(
                                text: TextSpan(
                                    style: GoogleFonts.lexendDeca(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                    children: const [
                                      TextSpan(
                                          text: 'Our suggestions for you '),
                                      WidgetSpan(
                                          child: Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.red,
                                        size: 16,
                                      ))
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            NewList(
                              locations: rawLocations,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: horizontalPadding),
                              child: RichText(
                                text: TextSpan(
                                    style: GoogleFonts.lexendDeca(
                                        color: black,
                                        fontWeight: FontWeight.bold),
                                    children: const [
                                      TextSpan(
                                          text: 'Parking locations for you '),
                                      WidgetSpan(
                                          child: Icon(
                                        Icons.star_rounded,
                                        color: Colors.orange,
                                        size: 16,
                                      ))
                                    ]),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            LocationList(
                              locations: rawLocations,
                            ),
                            verticalSpacer()
                          ],
                        );
                      })
                ],
              )),
        ),
      ),
    );
  }
}
