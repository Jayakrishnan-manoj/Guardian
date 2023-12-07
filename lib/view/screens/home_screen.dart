import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:guardian/view/widgets/custom_floatingbutton.dart';

import '../widgets/mini_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(
        ontap: () {
          setState(() {
            isAdd = !isAdd;
          });
        },
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
              Text(
                isAdd ? "Select A Category" : "Manage your Passwords",
                style: const TextStyle(
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
                      const Gap(18),
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
                  const Gap(18),
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
                      const Gap(18),
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
