import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarBar extends StatelessWidget {
  final double rate;
  final double size;
  final Function(double) onUpdate;
  bool fixed;
  bool half;
  double spacing;

  StarBar(
      {required this.rate,
      required this.size,
      this.fixed = false,
      this.spacing = 0,
      this.half = false,
      required this.onUpdate,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: size,
      ignoreGestures: fixed,
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: half,
      glow: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: spacing),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      glowColor: Colors.amber,
      unratedColor: Colors.grey[300],
      onRatingUpdate: (rate) => onUpdate(rate),
    );
  }
}
