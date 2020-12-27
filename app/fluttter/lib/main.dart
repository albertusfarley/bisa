import 'package:bisa/models/user.dart';
import 'package:bisa/screens/wrapper.dart';
import 'package:bisa/services/auth.dart';
import 'package:bisa/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final geolocatorServcie = GeolocatorService();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return StreamProvider<User>.value(
      value: AuthService().customUser,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark),
        child: FutureProvider(
            create: (context) => geolocatorServcie.getInitialLocation(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Bisa Parkir',
              theme: ThemeData(
                fontFamily: 'RobotoCondensed',
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: Wrapper(),
            )),
      ),
    );
  }
}
