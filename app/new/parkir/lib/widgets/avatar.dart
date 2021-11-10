import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/services/auth.dart';

class Avatar extends StatelessWidget {
  final double size;

  const Avatar({this.size = 48, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _auth = Get.find<AuthController>();

    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: _auth.user!.photoURL!,
        height: size,
        width: size,
        placeholder: (context, url) => Container(
            padding: const EdgeInsets.all(8),
            child: const CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
