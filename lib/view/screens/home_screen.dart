import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/add_password_screen.dart';
import 'package:guardian/view/widgets/category_card.dart';
import 'package:guardian/view/widgets/custom_dialog.dart';

import '../widgets/mini_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton:
      floatingActionButton: AvatarGlow(
        glowColor: buttonColor,
        endRadius: 80,
        duration: Duration(milliseconds: 2000),
        repeat: false,
        showTwoGlows: false,
        repeatPauseDuration: Duration(milliseconds: 2000),
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CustomDialog(),
            );
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => AddPasswordScreen(),
            //   ),
            // );
          },
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 12,
          ),
          child: Column(
            children: [
              const Text(
                "Manage your Passwords",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Gap(20),
              Column(
                children: [
                  Row(
                    children: [
                      MiniCategoryCard(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.globe,
                          color: Colors.white,
                        ),
                        title: "Browser",
                      ),
                      const Gap(15),
                      MiniCategoryCard(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        ),
                        title: "Social Media",
                      ),
                    ],
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      MiniCategoryCard(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        title: "Payments",
                      ),
                      const Gap(15),
                      MiniCategoryCard(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.category,
                          color: Colors.white,
                        ),
                        title: "Miscellaneous",
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
