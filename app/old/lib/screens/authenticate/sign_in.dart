import 'package:bisa/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bisa/shared/loading.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(left: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'BISA',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset('images/map_illustration.png')),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    child: RichText(
                      text: TextSpan(
                          text: 'Welcome',
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Finding parking space now made easy.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Sign in with Google and get started.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Colors.blueAccent,
                      )),
                  child: RawMaterialButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithGoogle();
                      if (result == null) {
                        setState(() {
                          print('Error singing in');
                          loading = false;
                        });
                      } else {
                        print('Signed in');
                        print('uid: ${result.uid}');
                      }
                    },
                    elevation: 0,
                    fillColor: Colors.white,
                    child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Image.asset('images/google_icon.png')),
                    padding: EdgeInsets.all(8),
                    shape: CircleBorder(),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
  }
}
