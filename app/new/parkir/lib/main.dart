import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:parkir/bindings/auth_binding.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/controllers/my_controller.dart';
import 'package:parkir/routes/routes.dart';
import 'package:parkir/screens/wrapper.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(MyController());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));

    return GetMaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'parkir',
      theme: ThemeData(
          scaffoldBackgroundColor: white,
          appBarTheme: const AppBarTheme(
              color: white,
              elevation: .0,
              titleTextStyle: TextStyle(
                  color: black, fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: black)),
          textTheme: GoogleFonts.lexendDecaTextTheme()),
      home: const Wrapper(),
      initialBinding: AuthBinding(),
      getPages: Routes.pages,
    );
  }
}
