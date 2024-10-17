import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/password_details_screen.dart';

class PasswordTile extends StatelessWidget {
  final Password password;

  bool isHome;
  PasswordTile({
    super.key,
    this.isHome = false,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) =>
                PasswordDetailsScreen(password: password),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
          // MaterialPageRoute(
          //   builder: (context) =>
          //       PasswordDetailsScreen(password: password),
          // ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: AppColors.tileColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              isHome
                  ? Hero(
                      tag: password.imagePath == null
                          ? "password image_${password.title}"
                          : "password image_${password.imagePath}",
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.blueAppColor,
                        child: password.imagePath != null
                            ? ClipOval(
                                child: Image.file(
                                  File(password.imagePath!),
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Text(
                                password.title.substring(0, 1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                    )
                  : CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.blueAppColor,
                      child: password.imagePath != null
                          ? ClipOval(
                              child: Image.file(
                                File(password.imagePath!),
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(
                              password.title.substring(0, 1),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                    ),
              Gap(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      password.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      password.username!,
                      style: TextStyle(
                        color: AppColors.subTextColor,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.subTextColor, width: 1.5)),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
