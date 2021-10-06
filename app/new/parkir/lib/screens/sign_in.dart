import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:parkir/constants/colors.dart';
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    AuthController _auth = Get.find();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            child: Image.asset('images/sign_in.png', fit: BoxFit.cover),
          ),
          loading
              ? const Loading()
              : Container(
                  constraints: const BoxConstraints.expand(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                            child: RichText(
                          text: const TextSpan(
                              style: TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                    text: 'BISA',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900)),
                                TextSpan(text: 'PARKIR')
                              ]),
                        )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customText(
                              text: 'LIHAT.\nDAPAT.\nPARKIR.',
                              color: white,
                              size: 32,
                              weight: FontWeight.w900),
                          const SizedBox(
                            height: 24,
                          ),
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(8)),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: customText(
                                    text: 'Masuk dengan Google',
                                    weight: FontWeight.bold,
                                    color: white),
                              ),
                            ),
                            onTap: () async {
                              _auth.signInWithGoogle();
                              setState(() {
                                loading = true;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: customText(
                                text: '*Menggunakan akun Google anda',
                                color: white,
                                size: 12),
                          )
                        ],
                      ),
                    ],
                  )),
        ],
      ),
    );
  }
}
