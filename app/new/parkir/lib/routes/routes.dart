import 'package:get/get.dart';
import 'package:parkir/bindings/auth_binding.dart';
import 'package:parkir/routes/route_name.dart';
import 'package:parkir/screens/sign_out.dart';
import 'package:parkir/screens/wrapper.dart';

class Routes {
  static final pages = [
    GetPage(
        name: RouteName.home,
        page: () => const Wrapper(),
        binding: AuthBinding()),
    GetPage(
        name: RouteName.signout,
        page: () => const SignOut(),
        binding: AuthBinding())
  ];
}
