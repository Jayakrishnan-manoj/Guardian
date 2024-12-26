import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guardian/controller/auth_provider.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:guardian/view/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final passwordRepository =
        Provider.of<PasswordRepository>(context, listen: false);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "GUARDIAN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Save your passwords securely and easily!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.subTextColor,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          isLoading
              ? Center(
                  child: const CircularProgressIndicator(
                    color: AppColors.blueAppColor,
                  ),
                )
              : SizedBox(
                  width: 400,
                  height: 55,
                  child: FilledButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.blueAppColor),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await AuthProvider()
                          .signInWithGoogle(context: context)
                          .then((result) async {
                        if (result != null) {
                          String? userName =
                              await passwordRepository.getSavedUser();
                          if (userName != null && userName.isNotEmpty) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => OnboardingScreen(),
                              ),
                            );
                          }
                        }
                      });
                      setState(() {
                        isLoading = false;
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Sign In With Google",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    ));
  }
}
