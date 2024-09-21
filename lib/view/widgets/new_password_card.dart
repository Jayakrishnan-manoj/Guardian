import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/new_password_screen.dart';
import 'package:sensors_plus/sensors_plus.dart';

class NewPasswordCard extends StatelessWidget {
  const NewPasswordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      //height: 200,
      decoration: BoxDecoration(
        color: AppColors.tileColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              radius: 25,
              child: const Icon(
                Icons.key_outlined,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            const Text(
              "New Password",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
            const Gap(5),
            const Text(
              "Save your new password with ease",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Gap(20),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 50,
              child: ElevatedButton(
                style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  shape: WidgetStatePropertyAll(
                    StadiumBorder(),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.greenAppColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewPasswordScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Add new +",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
