// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/onboarding_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final passwordRepository =
        Provider.of<PasswordRepository>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "GUARDIAN",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              IconButton(
                iconSize: 80,
                padding: const EdgeInsets.only(right: 40),
                onPressed: () async {
                  try {
                    bool pass = await authProvider.AuthenticateUser();
                    if (pass) {
                      final nextScreen = authProvider.handleAuthState();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => nextScreen,
                        ),
                      );
                      // String? userName = await passwordRepository.getSavedUser();
                      // if (userName != null && userName.isNotEmpty) {
                      //   Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //       builder: (context) => HomeScreen(),
                      //     ),
                      //   );
                      // } else {
                      //   Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //       builder: (context) => OnboardingScreen(),
                      //     ),
                      //   );
                      // }
                      // passwordRepository.getSavedUser().then((name) {
                      //   if (name != '') {
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) => OnboardingScreen(),
                      //       ),
                      //     );
                      //   } else {
                      //     Navigator.of(context).pushReplacement(
                      //       MaterialPageRoute(
                      //         builder: (context) => HomeScreen(),
                      //       ),
                      //     );
                      //   }
                      // });
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                icon: const Icon(
                  Icons.fingerprint,
                  color: AppColors.tileColor,
                  size: 80,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
