import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/routes/route_name.dart';
import 'package:parkir/screens/search_area.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/widgets/parking_list.dart';
import 'package:parkir/widgets/parking_tile.dart';
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

  AuthController _auth = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    return SafeArea(
      child: Scaffold(
        body: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 24),
          constraints: const BoxConstraints.expand(),
          child: ListView(
            children: [
              verticalSpacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: horizontalPadding),
                width: Get.width,
                height: 48,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(const SearchArea(),
                            transition: Transition.downToUp),
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            prefixIcon: const Icon(
                              Ionicons.search,
                              color: dark,
                            ),
                            hintText: 'Find parking location',
                            hintStyle: const TextStyle(color: grey),
                            filled: true,
                            enabled: false,
                            fillColor: grey.withOpacity(.05),
                            focusColor: dark,
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40),
                                borderSide:
                                    BorderSide(color: grey.withOpacity(.2))),
                          ),
                        ),
                      ),
                    ),
                    horizontalItemSpacer(),
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: _auth.user!.photoURL!,
                        height: 48,
                        width: 48,
                        placeholder: (context, url) => Container(
                            padding: const EdgeInsets.all(8),
                            child: const CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpacer(),
              const BannerList(),
              verticalSpacer(),
              const NewList(),
              verticalSpacer(),
              const ParkingList(),
              verticalSpacer(),
            ],
          ),
        ),
      ),
    );
  }
}
