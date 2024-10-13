// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:guardian/helpers/custom_toast.dart';
import 'package:guardian/services/generation_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/new_password_screen.dart';
import 'package:guardian/view/widgets/switch_tile.dart';

class GeneratePasswordPage extends StatefulWidget {
  const GeneratePasswordPage({super.key});

  @override
  State<GeneratePasswordPage> createState() => _GeneratePasswordPageState();
}

class _GeneratePasswordPageState extends State<GeneratePasswordPage> {
  int passwordLength = 4;
  bool includeNumbers = false;
  bool includeSymbols = false;
  bool includeLetters = true;

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(passwordController.text);
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "GENERATED PASSWORD",
              style: TextStyle(
                color: AppColors.subTextColor,
              ),
            ),
            Gap(10),
            TextField(
              onTap: () {
                if (passwordController.text.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewPasswordScreen(
                        password: passwordController.text,
                      ),
                    ),
                  );
                }
              },
              controller: passwordController,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              readOnly: true,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: passwordController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: passwordController.text),
                          ).then((_) {
                            Toasts().showSuccessToast(
                                context, "Password copied to clipboard");
                          });
                        },
                        icon: Icon(
                          FontAwesomeIcons.copy,
                          color: AppColors.scaffoldBackgroundColor,
                        ),
                      )
                    : null,
                contentPadding: EdgeInsets.symmetric(vertical: 40),
                filled: true,
                fillColor: AppColors.tileColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Gap(20),
            Text(
              "PASSWORD LENGTH : $passwordLength",
              style: TextStyle(color: AppColors.subTextColor),
            ),
            Gap(10),
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  color: AppColors.tileColor,
                  borderRadius: BorderRadius.circular(15)),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: AppColors.blueAppColor,
                  activeTrackColor: AppColors.blueAppColor,
                  inactiveTickMarkColor: const Color(0xFF8D8E98),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10.0,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 20.0,
                  ),
                  overlayColor: AppColors.blueAppColor.withOpacity(0.4),
                ),
                child: Slider(
                  min: 4,
                  max: 20,
                  value: passwordLength.toDouble(),
                  onChanged: (length) {
                    setState(() {
                      passwordLength = length.toInt();
                    });
                  },
                ),
              ),
            ),
            Gap(20),
            Text(
              "SETTINGS",
              style: TextStyle(
                color: AppColors.subTextColor,
              ),
            ),
            Gap(10),
            SwitchTile(
              parameter: includeNumbers,
              switchText: "Include Numbers",
              onChanged: (number) {
                setState(() {
                  includeNumbers = number;
                });
              },
            ),
            Gap(10),
            SwitchTile(
              parameter: includeLetters,
              switchText: "Include Letters",
              onChanged: (number) {
                setState(() {
                  includeLetters = number;
                });
              },
            ),
            Gap(10),
            SwitchTile(
              parameter: includeSymbols,
              switchText: "Include Symbols",
              onChanged: (number) {
                setState(() {
                  includeSymbols = number;
                });
              },
            ),
            Gap(40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(
                    StadiumBorder(),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.blueAppColor,
                  ),
                ),
                onPressed: () {
                  String generatedPassword =
                      PasswordGenerationService().generatePassword(
                    includeLetters: includeLetters,
                    includeNumbers: includeNumbers,
                    includeSymbols: includeSymbols,
                    length: passwordLength,
                  );
                        
                  setState(() {
                    passwordController.text = generatedPassword;
                  });
                },
                child: Text(
                  "Generate Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
