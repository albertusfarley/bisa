import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkir/screens/home_shimmer.dart';
import 'package:parkir/screens/home.dart';
import 'package:parkir/screens/sign_in.dart';
import 'package:parkir/services/auth.dart';

class Wrapper extends GetWidget<AuthController> {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.user == null ? const SignIn() : const Home();
    });
  }
}
