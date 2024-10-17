// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/all_passwords_screen.dart';
import 'package:guardian/view/screens/generate_password_page.dart';
import 'package:guardian/view/screens/profile_page.dart';
import 'package:guardian/view/widgets/new_password_card.dart';
import 'package:guardian/view/widgets/password_tile.dart';
import 'package:provider/provider.dart';

import '../../data/repositories/password_repository.dart';
import '../widgets/mini_category_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAdd = false;
  late PageController _pageController;
  int selectedIndex = 0;

  late Stream<List<Password>> passwordStream;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
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
          child: Stack(
            children: [
              PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  HomePage(),
                  const GeneratePasswordPage(),
                  const ProfilePage(),
                ],
              ),
              Positioned(
                bottom: 20,
                //top: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        width: MediaQuery.sizeOf(context).width * 0.87,
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.home,
                                size: 35,
                                color: selectedIndex == 0
                                    ? AppColors.blueAppColor
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 0;
                                });
                                _pageController.animateToPage(0,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.wand_stars,
                                size: 35,
                                color: selectedIndex == 1
                                    ? AppColors.blueAppColor
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 1;
                                });
                                _pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                CupertinoIcons.person_alt_circle,
                                size: 35,
                                color: selectedIndex == 2
                                    ? AppColors.blueAppColor
                                    : Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  selectedIndex = 2;
                                });
                                _pageController.animateToPage(2,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn);
                              },
                            ),
                          ],
                        ),
                      ),
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

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final passwordRepository = Provider.of<PasswordRepository>(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                  future: passwordRepository.getSavedUser(),
                  builder: (context, user) {
                    return Text(
                      "Hello, ${user.data.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
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
                        category: Categories.browser,
                        icon: const FaIcon(
                          FontAwesomeIcons.globe,
                          size: 35,
                          color: Colors.white,
                        ),
                        title: "Browser",
                      ),
                      const Gap(18),
                      MiniCategoryCard(
                        category: Categories.socialMedia,
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
                        category: Categories.payments,
                        icon: const Icon(
                          Icons.wallet,
                          size: 35,
                          color: Colors.white,
                        ),
                        title: "Payments",
                      ),
                      const Gap(18),
                      MiniCategoryCard(
                        category: Categories.miscellaneous,
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
              Row(
                children: [
                  Expanded(
                    child: const Text(
                      "Recently Saved",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AllPasswordsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "See All",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.blueAppColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
              Gap(15),
            ],
          ),
        ),
        StreamBuilder<List<Password>>(
          stream: passwordRepository.watchPasswords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            }
            if (snapshot.hasError) {
              return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')));
            }
            if (snapshot.data == null) {
              return SliverToBoxAdapter(
                  child: Center(child: Text("No data available")));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return SliverToBoxAdapter(
                  child: Center(child: Text('No passwords saved yet')));
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final password = snapshot.data![index];
                  return PasswordTile(
                    isHome: true,
                   password: password,
                  );
                },
                childCount: snapshot.data!.length,
              ),
            );
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 60,
          ),
        )
      ],
    );
  }
}
