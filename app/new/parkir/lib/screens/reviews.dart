import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/models/review.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/services/tools.dart';
import 'package:parkir/widgets/ask_rate.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/loading.dart';
import 'package:parkir/widgets/rates.dart';
import 'package:parkir/widgets/review_tile.dart';

class Reviews extends StatefulWidget {
  final String id;
  final String name;
  final Map rates;

  const Reviews(
      {required this.id, required this.name, required this.rates, Key? key})
      : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  AuthController _auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    bool rated = Tools.totalReviews(rates: widget.rates) > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder<DocumentSnapshot>(
          stream: DatabaseService().getReviews(id: widget.id),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }

            Map reviews = snapshot.data!.data() as Map;
            List sortedReviews = reviews.entries
                .map((e) => Review(reviewID: e.key, raw: e.value))
                .toList()
              ..sort((b, a) => a.date.compareTo(b.date));

            Review? myReview = sortedReviews.firstWhereOrNull(
                (review) => review.email == _auth.user!.email);

            return ListView(
              children: [
                verticalItemSpacer(),
                if (rated)
                  Column(
                    children: [
                      Rates(rates: widget.rates),
                      verticalItemSpacer(),
                    ],
                  ),
                myReview == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: 'Share your experience',
                              weight: FontWeight.bold),
                          verticalItemSpacer(),
                          AskRate(
                              id: widget.id,
                              name: widget.name,
                              rates: widget.rates),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: 'Review by you', weight: FontWeight.bold),
                          verticalItemSpacer(),
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: light,
                                borderRadius: BorderRadius.circular(24)),
                            child: ReviewTile(
                              context: context,
                              locID: widget.id,
                              rates: widget.rates,
                              myEmail: _auth.user!.email!,
                              review: myReview,
                              withBottomBorder: false,
                            ),
                          ),
                        ],
                      ),
                reviews.isEmpty
                    ? Container(
                        width: Get.width,
                        height: Get.width,
                        alignment: Alignment.center,
                        child: customText(text: 'Be the first.', color: grey),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            verticalItemSpacer(),
                            Container(
                              padding: EdgeInsets.only(bottom: 16),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: .5,
                                          color: Colors.grey[300]!))),
                              child: customText(
                                  text: 'Review by other',
                                  weight: FontWeight.bold),
                            ),
                            for (var review in sortedReviews)
                              ReviewTile(
                                  context: context,
                                  locID: widget.id,
                                  rates: widget.rates,
                                  myEmail: _auth.user!.email!,
                                  review: review),
                          ]),
              ],
            );
          }),
    );
  }
}
