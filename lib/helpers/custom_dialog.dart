import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/view/constants/colors.dart';

void showCustomDialog(BuildContext context, VoidCallback onPressed) {
  showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Colors.white.withOpacity(0.1),
            title: Text(
              "Delete Password?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            content: Text(
              "Are you sure you want to delete the password? This action cannot be undone.",
              style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            StadiumBorder(),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          elevation: WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            StadiumBorder(),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.red,
                          ),
                        ),
                        onPressed: onPressed,
                        child: const Text(
                          "Delete",
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
            ],
          ),
        );
      });
}
