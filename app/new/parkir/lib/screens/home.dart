import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/models/dummy.dart';
import 'package:parkir/routes/route_name.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/widgets/custom_text.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  List<String> buildings = Dummy.kampus;
  AuthController _auth = Get.find();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //       constraints: const BoxConstraints.expand(),
    //       child: Center(
    //         child: TextButton(
    //             onPressed: () => Get.toNamed(RouteName.signout),
    //             child: customText(text: 'Navigate', color: primary)),
    //       )),
    // );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          constraints: const BoxConstraints.expand(),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        await _auth.signOut();
                        Get.offNamed(RouteName.home);
                      },
                      child: customText(text: 'Sign Out', color: Colors.red)),
                  RichText(
                      text: TextSpan(
                          style: const TextStyle(color: black),
                          children: [
                        const TextSpan(text: 'Hi, '),
                        TextSpan(
                            text: _auth.user!.name,
                            style: const TextStyle(fontWeight: FontWeight.bold))
                      ])),
                  const SizedBox(
                    width: 16,
                  ),
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: _auth.user!.photoURL!,
                      height: 40,
                      width: 40,
                      placeholder: (context, url) => Container(
                          padding: const EdgeInsets.all(8),
                          child: const CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: searchController,
                onChanged: (String str) => setState(() {
                  buildings = Dummy.kampus
                      .where((String building) => building
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()))
                      .toList();
                }),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: searchController.text == ''
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                searchController.text = '';
                              });
                            },
                            icon: const Icon(Icons.cancel)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16)),
                    hintText: 'Cari Lokasi'),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView(
                children: [
                  for (String kampus in buildings)
                    Column(
                      children: [
                        Card(
                          color: grey.withOpacity(.1),
                          elevation: .0,
                          child: ListTile(
                            title: customText(text: kampus),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        )
                      ],
                    )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
