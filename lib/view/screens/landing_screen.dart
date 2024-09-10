// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:local_auth/local_auth.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(right: 40),
                onPressed: () async {
                  try {
                    bool pass = await auth.authenticate(
                        localizedReason: 'Authenticate to continue',
                        options: const AuthenticationOptions(biometricOnly: true));
                    if (pass) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  } on PlatformException catch (e) {
                    print(e.message);
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
