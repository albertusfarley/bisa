import 'package:get/get.dart';
import 'package:parkir/services/auth.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    // ignore: todo
    // TODO: implement dependencies
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
