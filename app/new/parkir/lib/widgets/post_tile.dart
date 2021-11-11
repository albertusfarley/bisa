import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/parking_name.dart';
import 'package:parkir/models/post.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class PostTile extends StatelessWidget {
  final Post post;

  const PostTile({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalItemPadding),
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  post.thumbnail,
                  height: 32,
                  width: 32,
                ),
              ),
              horizontalItemSpacer(),
              ParkingName(raw: post.publisher).widget(),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        AspectRatio(
          aspectRatio: 2,
          child: Image.network(post.imageURL),
        ),
        if (post.hyperlink != '')
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 10),
            width: double.infinity,
            color: dark,
            child: GestureDetector(
                onTap: () {
                  launch(post.hyperlink);
                },
                child: Row(
                  children: [
                    const Icon(
                      Ionicons.globe_outline,
                      size: 16,
                      color: white,
                    ),
                    customText(text: ' Go to Link', color: white)
                  ],
                )),
          ),
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      style: GoogleFonts.lexendDeca(color: dark),
                      children: [
                        TextSpan(
                            text: ParkingName(raw: post.publisher).text + ' ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: post.caption,
                            style: TextStyle(color: darkGrey))
                      ])),
              const SizedBox(
                height: 4,
              ),
              customText(text: timeago.format(post.date), color: grey, size: 12)
            ],
          ),
        ),
      ],
    );
  }
}
