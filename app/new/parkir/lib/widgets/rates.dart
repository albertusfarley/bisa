import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/padding.dart';
import 'package:parkir/services/tools.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/star_bar.dart';

class Rates extends StatelessWidget {
  final Map rates;

  const Rates({required this.rates, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalRates = Tools.totalRates(rates: rates);
    int totalReviews = Tools.totalReviews(rates: rates);
    int mostRate = Tools.mostRate(rates: rates);
    double rate = Tools.ratesAverage(rates: rates);

    return totalRates == 0
        ? Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: customText(text: 'No Reviews', color: grey),
          )
        : IntrinsicHeight(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: horizontalItemPadding),
              child: Row(
                children: [
                  Column(
                    children: [
                      customText(text: rate.toString(), size: 32),
                      StarBar(
                          rate: rate,
                          size: 16,
                          fixed: true,
                          half: true,
                          onUpdate: (rate) {}),
                      customText(text: '($totalReviews)', color: grey)
                    ],
                  ),
                  horizontalItemSpacer(),
                  horizontalItemSpacer(),
                  Expanded(
                    child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: rates.entries
                              .map((e) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      color: lightGrey,
                                      alignment: Alignment.centerLeft,
                                      height: 4,
                                      width: double.infinity,
                                      child: FractionallySizedBox(
                                        heightFactor: 1,
                                        widthFactor: e.value / mostRate,
                                        child: Container(
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList()
                              .reversed
                              .toList()),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
