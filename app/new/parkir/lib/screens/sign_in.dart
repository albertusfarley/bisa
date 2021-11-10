import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkir/constants/colors.dart';
import 'package:parkir/constants/shadow.dart';
import 'package:parkir/services/auth.dart';
import 'package:parkir/widgets/custom_text.dart';
import 'package:parkir/widgets/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    AuthController _auth = Get.find();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: loading
            ? const Loading()
            : Container(
                constraints: const BoxConstraints.expand(),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          color: light,
                          padding: const EdgeInsets.symmetric(horizontal: 64),
                          child: Image.asset('images/login.png',
                              fit: BoxFit.contain)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        constraints: BoxConstraints.expand(),
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        color: white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: GoogleFonts.lexendDeca(
                                        color: dark,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    children: const [
                                      TextSpan(text: 'We bring '),
                                      TextSpan(
                                          text: 'future',
                                          style: TextStyle(color: primary)),
                                      TextSpan(text: ' to\nparking industry')
                                    ])),
                            customText(
                                text: 'Park Better. Park Faster.', color: grey),
                            GestureDetector(
                              onTap: () async {
                                _auth.signInWithGoogle();
                                setState(() {
                                  loading = true;
                                });
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: primary,
                                      boxShadow: listShadow),
                                  child: customText(
                                      text: 'Sign in with Google',
                                      color: white,
                                      weight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
