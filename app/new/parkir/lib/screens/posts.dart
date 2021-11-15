import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/post.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/location_tile.dart';
import 'package:parkir/widgets/post_tile.dart';
import 'package:timeago/timeago.dart' as timeago;

class Posts extends StatelessWidget {
  final String id;
  final String thumbnail;
  final String name;

  const Posts(
      {required this.id, required this.name, required this.thumbnail, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService().getLocationPosts(id: id),
        builder: (_,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SizedBox.shrink();

          List posts = snapshot.data!.data()!.values.toList();

          Image profilePicture = Image.network(
            thumbnail,
            height: 32,
            width: 32,
            fit: BoxFit.fill,
          );
          return ListView.separated(
            padding: EdgeInsets.only(
                top: verticalItemPadding / 2, bottom: verticalPadding * 2),
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (_, index) => PostTile(
              post: Post(
                publisher: name,
                thumbnail: thumbnail,
                postRaw: posts[index],
              ),
            ),
            itemCount: posts.length,
            separatorBuilder: (_, index) => const SizedBox(
              height: verticalItemPadding,
            ),
          );
        });
  }
}
