import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/login_screen.dart';
import 'package:local_auth/local_auth.dart';

enum authStatus { initial, authenticated, notAuthenticated }

final LocalAuthentication auth = LocalAuthentication();

class AuthProvider extends ChangeNotifier {
  authStatus _authStatus = authStatus.initial;
  authStatus get authState => _authStatus;

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(ConnectionState == ConnectionState.waiting){
            return const Center(
            child: CircularProgressIndicator(
              color: AppColors.blueAppColor,
            ),
          );
          }else if(snapshot.hasData){
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
  }

  Future<bool> AuthenticateUser() async {
    print("current auth status is $authState");
    try {
      print("in the try block now");
      bool pass = await auth.authenticate(
          localizedReason: 'Authenticate to continue',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true));
      if (pass) {
        _authStatus = authStatus.authenticated;
        print("user authenticated");
        return true;
      } else {
        _authStatus = authStatus.notAuthenticated;
        print("user not authenticated");
        return false;
      }
    } on PlatformException catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
    }

    return user;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
