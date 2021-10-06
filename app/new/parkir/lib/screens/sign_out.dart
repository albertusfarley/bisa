import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/models/user.dart';
import 'package:parkir/routes/route_name.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/widgets/custom_text.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _auth = Get.find();
    MyUser myUser = _auth.user!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Out'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customText(text: myUser.name!, weight: FontWeight.bold),
                    customText(text: myUser.email!),
                  ],
                ),
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: myUser.photoURL!,
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
            const SizedBox(
              height: 24,
            ),
            TextButton(
                onPressed: () async {
                  await _auth.signOut();
                  Get.offNamed(RouteName.home);
                },
                child: customText(text: 'Sign Out', color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
