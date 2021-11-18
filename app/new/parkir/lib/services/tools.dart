import 'package:get/get.dart';

class Tools {
  static int totalReviews({required Map rates}) =>
      rates.values.reduce((a, b) => a + b);

  static int totalRates({required Map rates}) => rates.entries
      .map((e) => (int.parse(e.key) * e.value))
      .toList()
      .reduce((a, b) => a + b)
      .toInt();

  static double ratesAverage({required Map rates}) {
    int reviews = totalReviews(rates: rates);

    if (reviews > 0) {
      double newRate = totalRates(rates: rates) / totalReviews(rates: rates);

      return double.parse(newRate.toStringAsFixed(1));
    } else {
      return .0;
    }
  }

  static int mostRate({required Map rates}) =>
      rates.values.reduce((curr, next) => curr > next ? curr : next);

  static void toastMessage({required String text}) {
    Get.showSnackbar(GetBar(
      duration: const Duration(seconds: 3),
      message: text,
      animationDuration: const Duration(milliseconds: 250),
    ));
  }
}
