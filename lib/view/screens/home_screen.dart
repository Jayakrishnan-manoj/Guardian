import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/generate_password_page.dart';
import 'package:guardian/view/screens/profile_page.dart';
import 'package:guardian/view/widgets/custom_floatingbutton.dart';
import 'package:guardian/view/widgets/new_password_card.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../widgets/mini_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdd = false;
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 12,
          ),
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: const [
              HomePage(),
              GeneratePasswordPage(),
              ProfilePage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: AppColors.tileColor,
        iconSize: 32,
        selectedIndex: selectedIndex,
        onButtonPressed: onButtonPressed,
        activeColor: AppColors.greenAppColor,
        barItems: [
          BarItem(title: "Home", icon: CupertinoIcons.home),
          BarItem(title: "Generate", icon: CupertinoIcons.wand_stars),
          BarItem(title: "Profile", icon: CupertinoIcons.person_alt_circle)
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello, JayK",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(8),
        const Text(
          "Save your passwords easily and securely",
          style: TextStyle(
            color: AppColors.subTextColor,
            fontSize: 16,
          ),
        ),
        const Gap(20),
        const NewPasswordCard(),
        const Gap(20),
        Column(
          children: [
            Row(
              children: [
                MiniCategoryCard(
                  onPressed: () {},
                  icon: const FaIcon(
                    FontAwesomeIcons.globe,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: "Browser",
                ),
                const Gap(18),
                MiniCategoryCard(
                  onPressed: () {},
                  icon: const Icon(
                    size: 35,
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
                    size: 35,
                    color: Colors.white,
                  ),
                  title: "Payments",
                ),
                const Gap(18),
                MiniCategoryCard(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.category,
                    size: 35,
                    color: Colors.white,
                  ),
                  title: "Miscellaneous",
                ),
              ],
            ),
          ],
        ),
        const Gap(20),
        const Text(
          "Saved Passwords",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        )
      ],
    );
  }
}
