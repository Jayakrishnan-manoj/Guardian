import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/widgets/category_card.dart';

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
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 2000),
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: () {},
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
            horizontal: 5,
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
                      CategoryCard(
                        categoryIcon: FaIcon(
                          FontAwesomeIcons.globe,
                          color: Colors.white,
                        ),
                        categoryTitle: "Browser",
                      ),
                      Gap(3),
                      CategoryCard(
                        categoryIcon: Icon(
                          Icons.phone_android,
                          color: Colors.white,
                        ),
                        categoryTitle: "Social Media",
                      ),
                    ],
                  ),
                  Gap(3),
                  Row(
                    children: [
                      CategoryCard(
                        categoryIcon: Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        categoryTitle: "Payments",
                      ),
                      Gap(3),
                      CategoryCard(
                        categoryIcon: Icon(
                          Icons.category,
                          color: Colors.white,
                        ),
                        categoryTitle: "Miscellaneous",
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
