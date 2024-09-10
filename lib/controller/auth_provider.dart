import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum authStatus { initial, authenticated, notAuthenticated }

final LocalAuthentication auth = LocalAuthentication();

class AuthProvider extends ChangeNotifier {
  authStatus _authStatus = authStatus.initial;
  authStatus get authState => _authStatus;

  Future<bool> AuthenticateUser() async {
    try {
      bool pass = await auth.authenticate(
          localizedReason: 'Authenticate to continue',
          options: const AuthenticationOptions(biometricOnly: true));
      if (pass) {
        _authStatus = authStatus.authenticated;
        return true;
      } else {
        _authStatus = authStatus.notAuthenticated;
        return false;
      }
    } on PlatformException {
      return false;
    }
  }
}
