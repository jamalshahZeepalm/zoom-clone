import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<User?> _user = Rx<User?>(null);
  User? get getUser => _user.value;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(auth.authStateChanges());

    update();
  }

  Future<bool> signinWithGoogls() async {
    bool res = false;
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firebaseFirestore.collection('Users').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            'profileImage': user.photoURL,
            'email': user.email
          });
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      res = false;
    }
    return res;
  }

   userLogout() async {
    await auth.signOut();
  }
}
