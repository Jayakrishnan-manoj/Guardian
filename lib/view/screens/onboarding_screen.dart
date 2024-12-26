import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/data/models/user_schema.dart';
import 'package:guardian/data/repositories/password_repository.dart';
import 'package:guardian/helpers/custom_toast.dart';
import 'package:guardian/services/encryption_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  bool _isDescriptionVisible = false;

  @override
  Widget build(BuildContext context) {
    final passwordRepository =
        Provider.of<PasswordRepository>(context, listen: false);
    final TextEditingController nameController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30.0,
            top: 35,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedTextKit(
                repeatForever: false,
                isRepeatingAnimation: false,
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Welcome to Guardian",
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                    ),
                    speed: Duration(
                      milliseconds: 100,
                    ),
                  ),
                  TypewriterAnimatedText(
                    "What should we call you?",
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.w700,
                    ),
                    speed: Duration(
                      milliseconds: 100,
                    ),
                  ),
                ],
              ),
              Gap(30),
              Text(
                "ENTER YOUR NAME",
                style: TextStyle(
                  color: AppColors.subTextColor,
                  fontSize: 16,
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: nameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.scaffoldBackgroundColor,
                              width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      hintStyle: TextStyle(color: AppColors.subTextColor),
                      filled: true,
                      fillColor: AppColors.tileColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              // Gap(50),
              // Padding(
              //   padding: const EdgeInsets.only(right: 30),
              //   child: SizedBox(
              //     height: 60,
              //     width: double.infinity,
              //     child: ElevatedButton(
              //       onPressed: () async {
              //         UserSchema user = UserSchema()
              //           ..name = nameController.text;
              //         await passwordRepository.saveUser(user).whenComplete(() {
              //           Navigator.of(context).pushReplacement(MaterialPageRoute(
              //               builder: (context) => HomeScreen()));
              //           Toasts().showSuccessToast(
              //               context, "Welcome ${nameController.text}");
              //         });
              //       },
              //       style: const ButtonStyle(
              //         elevation: WidgetStatePropertyAll(0),
              //         shape: WidgetStatePropertyAll(
              //           StadiumBorder(),
              //         ),
              //         backgroundColor: WidgetStatePropertyAll(
              //           AppColors.blueAppColor,
              //         ),
              //       ),
              //       child: Text(
              //         "Continue",
              //         style: TextStyle(
              //             fontSize: 18,
              //             color: Colors.white,
              //             fontWeight: FontWeight.w700),
              //       ),
              //     ),
              //   ),
              // ),
              //Gap(20),
              // Row(
              //   children: [
              //     Text(
              //       "SET A MASTER PASSWORD",
              //       style: TextStyle(
              //         color: AppColors.subTextColor,
              //         fontSize: 16,
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         setState(() {
              //           _isDescriptionVisible = !_isDescriptionVisible;
              //         });
              //       },
              //       icon: Icon(
              //         Icons.help_outline,
              //         color: AppColors.subTextColor,
              //       ),
              //     ),
              //   ],
              // ),
              // AnimatedSize(
              //   duration: Duration(milliseconds: 300),
              //   //curve: Curves.easeIn,
              //   child: _isDescriptionVisible
              //       ? Text(
              //           "Set a strong Master Password. This will be used to access the backup in case of data loss",
              //           style: TextStyle(
              //             color: AppColors.subTextColor,
              //           ),
              //         )
              //       : SizedBox.shrink(),
              // ),

              // Gap(10),
              // Padding(
              //   padding: const EdgeInsets.only(right: 30),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: TextField(
              //       controller: nameController,
              //       style: const TextStyle(color: Colors.white),
              //       decoration: InputDecoration(
              //         focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //                 color: AppColors.scaffoldBackgroundColor,
              //                 width: 2),
              //             borderRadius: BorderRadius.circular(15)),
              //         hintStyle: TextStyle(color: AppColors.subTextColor),
              //         filled: true,
              //         fillColor: AppColors.tileColor,
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Gap(50),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      UserSchema user = UserSchema()
                        ..name = nameController.text;
                      await passwordRepository.saveUser(user).whenComplete(() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                        Toasts().showSuccessToast(
                            context, "Welcome ${nameController.text}");
                      });
                    },
                    // onPressed: () async {
                    //   final recoveryPhrase = EncryptionService().generateRecoveryPhrase();
                    //   print(recoveryPhrase);
                    // },
                    //   UserSchema user = UserSchema()
                    //     ..name = nameController.text;
                    //   await passwordRepository.saveUser(user).whenComplete(() {
                    //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //         builder: (context) => HomeScreen()));
                    //     Toasts().showSuccessToast(
                    //         context, "Welcome ${nameController.text}");
                    //   });
                    // },
                    style: const ButtonStyle(
                      elevation: WidgetStatePropertyAll(0),
                      shape: WidgetStatePropertyAll(
                        StadiumBorder(),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        AppColors.blueAppColor,
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
