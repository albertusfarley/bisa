import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/constants/shadow.dart';
import 'package:parkir/models/location_name.dart';
import 'package:parkir/models/review.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/services/database.dart';
import 'package:parkir/services/tools.dart';
import 'package:parkir/widgets/avatar.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/star_bar.dart';

class RateScreen extends StatefulWidget {
  final String name;
  final String id;
  double rate;
  final double currentRate;
  final Map rates;

  RateScreen(
      {required this.id,
      required this.name,
      required this.rate,
      required this.currentRate,
      required this.rates,
      Key? key})
      : super(key: key);

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  AuthController _auth = Get.find<AuthController>();
  TextEditingController _reviewController = TextEditingController();

  Future postReview(String text) async {
    {
      FocusScope.of(context).unfocus();

      int date = DateTime.now().millisecondsSinceEpoch;

      DatabaseService().setReviews(
        id: widget.id,
        review: Review(reviewID: date.toString(), raw: {
          'email': _auth.user!.email,
          'name': _auth.user!.name,
          'photo_url': _auth.user!.photoURL,
          'date': date,
          'rate': widget.rate,
          'review': text
        }),
        rates: widget.rates,
      );
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: LocationName(raw: widget.name).widget(size: 16),
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              size: 20,
            )),
        backgroundColor: white,
        elevation: 0,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          constraints: const BoxConstraints.expand(),
          child: ListView(
            children: [
              Row(
                children: [
                  Avatar(),
                  horizontalItemSpacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(text: _auth.user!.name!),
                      Row(
                        children: [
                          customText(
                              text: 'Posting Publicly ', size: 12, color: grey),
                          const Icon(
                            Ionicons.globe_outline,
                            color: grey,
                            size: 12,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              verticalSpacer(),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: verticalItemPadding),
                child: StarBar(
                    fixed: false,
                    rate: widget.rate,
                    size: 40,
                    spacing: Get.width / 32,
                    onUpdate: (rate) {
                      setState(() {
                        widget.rate = rate;
                      });
                    }),
              ),
              verticalSpacer(),
              customText(text: 'Share more about your experience'),
              verticalItemSpacer(half: true),
              TextField(
                controller: _reviewController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.send,
                onSubmitted: (text) => postReview(_reviewController.text),
                maxLines: 5,
                minLines: 5,
                maxLength: 240,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                    hintMaxLines: 5,
                    hintText:
                        'Write your parking experience in this location...',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: grey),
                        borderRadius: BorderRadius.circular(8))),
              ),
              verticalItemSpacer(),
              GestureDetector(
                onTap: () {
                  postReview(_reviewController.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: listShadow),
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 48,
                  child: customText(
                      text: 'Post', weight: FontWeight.bold, color: white),
                ),
              )
            ],
          )),
    );
  }
}
