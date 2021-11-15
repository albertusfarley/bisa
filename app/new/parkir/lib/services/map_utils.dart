import 'package:parkir/services/tools.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Tools.toastMessage(text: 'Could not open the map');
      // throw 'Could not open the map.';
    }
  }
}
