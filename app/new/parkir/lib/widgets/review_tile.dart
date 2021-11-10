import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/review.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/services/tools.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/star_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewTile extends StatelessWidget {
  final BuildContext context;
  final String locID;
  final Map rates;
  final Review review;
  final String myEmail;
  final bool withBottomBorder;

  const ReviewTile(
      {required this.context,
      required this.locID,
      required this.rates,
      required this.review,
      required this.myEmail,
      this.withBottomBorder = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool myReview = review.email == myEmail;

    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom: withBottomBorder
                  ? BorderSide(width: .5, color: Colors.grey[300]!)
                  : BorderSide.none)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      review.photoURL,
                      height: 32,
                      width: 32,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  customText(text: review.name, weight: FontWeight.bold)
                ],
              ),
              if (myReview)
                PopupMenuButton(
                    icon: const Icon(Ionicons.ellipsis_vertical),
                    iconSize: 16,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: light,
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            height: 0,
                            child:
                                customText(text: "Delete", color: Colors.red),
                            onTap: () {
                              DatabaseService()
                                  .deleteReviews(
                                      id: locID, review: review, rates: rates)
                                  .then((value) => Tools.toastMessage(
                                      text: 'Review deleted.'));
                            },
                          ),
                        ])
              // IconButton(
              //     onPressed: () {
              //       // Tools.showToast(context);
              //     },
              //     icon: Icon(
              //       Ionicons.ellipsis_vertical,
              //       size: 16,
              //       color: dark,
              //     ))
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              StarBar(rate: review.rate, size: 16, onUpdate: (rate) {}),
              horizontalItemSpacer(half: true),
              customText(
                  text: timeago
                      .format(DateTime.fromMillisecondsSinceEpoch(review.date)),
                  color: grey,
                  size: 12)
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          if (review.review.isNotEmpty)
            customText(text: review.review, color: darkGrey)
        ],
      ),
    );
  }
}
