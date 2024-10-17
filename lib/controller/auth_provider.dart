import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum authStatus { initial, authenticated, notAuthenticated }

final LocalAuthentication auth = LocalAuthentication();

class AuthProvider extends ChangeNotifier {
  authStatus _authStatus = authStatus.initial;
  authStatus get authState => _authStatus;

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
    } on PlatformException catch(e){
      print(e.toString());
      return false;
    }
  }
}
