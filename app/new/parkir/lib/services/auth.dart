import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkir/models/user.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create custom user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? MyUser(
            email: user.email,
            uid: user.uid,
            name: user.displayName,
            photoURL: user.photoURL,
          )
        : null;
  }

  final Rxn<MyUser> _userFromFirebase = Rxn<MyUser>();
  MyUser? get user => _userFromFirebase.value;

  @override
  // ignore: must_call_super
  void onInit() {
    _userFromFirebase
        .bindStream(_auth.authStateChanges().map(_userFromFirebaseUser));
  }

  // User stream
  Stream<MyUser?> get streamUser {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in with Google
  Future signInWithGoogle() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signInSilently() ?? await _googleSignIn.signIn();

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await _auth.signInWithCredential(credential);
    } catch (_) {
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {
      return null;
    }
  }
}
