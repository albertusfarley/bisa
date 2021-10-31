import 'package:flutter/cupertino.dart';

const double horizontalPadding = 16.0;
const double verticalPadding = 24.0;
const double horizontalItemPadding = 16.0;
const double verticalItemPadding = 24.0;

verticalSpacer() => const SizedBox(
      height: verticalPadding,
    );

horizontalItemSpacer({bool half = false}) =>
    SizedBox(width: half ? horizontalItemPadding / 2 : horizontalItemPadding);
verticalItemSpacer({bool half = false}) =>
    SizedBox(height: half ? verticalItemPadding / 2 : verticalItemPadding);
