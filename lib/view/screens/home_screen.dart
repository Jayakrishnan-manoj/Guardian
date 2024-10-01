import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:guardian/data/service/database_service.dart';
import 'package:guardian/services/encryption_service.dart';
import 'package:guardian/view/constants/colors.dart';
import 'package:guardian/view/screens/generate_password_page.dart';
import 'package:guardian/view/screens/password_details_screen.dart';
import 'package:guardian/view/screens/profile_page.dart';
import 'package:guardian/view/widgets/new_password_card.dart';
import 'package:guardian/view/widgets/password_tile.dart';
import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

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
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              HomePage(),
              const GeneratePasswordPage(),
              const ProfilePage(),
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
    final passwordRepository = Provider.of<PasswordRepository>(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
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
                        category: Categories.browser,
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
                        category: Categories.socialMedia,
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
                        category: Categories.payments,
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
                        category: Categories.miscellaneous,
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PasswordDetailsScreen(password: password),
                        ),
                      );
                    },
                    child: PasswordTile(
                      title: password.title,
                      username: password.username,
                      imagePath: password.imagePath,
                    ),
                  );
                },
                childCount: snapshot.data!.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

// class HomePage extends StatelessWidget {
//   final DatabaseService databaseService;
//   const HomePage({
//     super.key,
//     required this.databaseService,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Hello, JayK",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 32,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const Gap(8),
//           const Text(
//             "Save your passwords easily and securely",
//             style: TextStyle(
//               color: AppColors.subTextColor,
//               fontSize: 16,
//             ),
//           ),
//           const Gap(20),
//           const NewPasswordCard(),
//           const Gap(20),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   MiniCategoryCard(
//                     category: Categories.browser,
//                     onPressed: () {},
//                     icon: const FaIcon(
//                       FontAwesomeIcons.globe,
//                       size: 35,
//                       color: Colors.white,
//                     ),
//                     title: "Browser",
//                   ),
//                   const Gap(18),
//                   MiniCategoryCard(
//                     category: Categories.socialMedia,
//                     onPressed: () {},
//                     icon: const Icon(
//                       size: 35,
//                       Icons.phone_android,
//                       color: Colors.white,
//                     ),
//                     title: "Social Media",
//                   ),
//                 ],
//               ),
//               const Gap(18),
//               Row(
//                 children: [
//                   MiniCategoryCard(
//                     category: Categories.payments,
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.wallet,
//                       size: 35,
//                       color: Colors.white,
//                     ),
//                     title: "Payments",
//                   ),
//                   const Gap(18),
//                   MiniCategoryCard(
//                     category: Categories.miscellaneous,
//                     onPressed: () {},
//                     icon: const Icon(
//                       Icons.category,
//                       size: 35,
//                       color: Colors.white,
//                     ),
//                     title: "Miscellaneous",
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const Gap(20),
//           const Text(
//             "Saved Passwords",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w700,
//               fontSize: 22,
//             ),
//           ),
//           Gap(15),
//           StreamBuilder<List<Password>>(
//               stream: databaseService.listenPasswords(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 // if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 //   return Center(child: Text('No passwords saved yet'));
//                 // }
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (snapshot.data == null) {
//                   return Center(
//                       child: Text(
//                           "no dataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"));
//                 }
//                 if (!snapshot.hasData) {
//                   return Center(child: Text('No data available'));
//                 }
//                 if (snapshot.data!.isEmpty) {
//                   return Center(child: Text('No passwords saved yet'));
//                 }
//                 return SizedBox(
//                   height: 500,
//                   child: ListView.builder(
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         final password = snapshot.data![index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     PasswordDetailsScreen(password: password),
//                               ),
//                             );
//                           },
//                           child: PasswordTile(
//                             title: password.title,
//                             username: password.username,
//                             imagePath: password.imagePath,
//                           ),
//                         );
//                       }),
//                 );
//               })
//         ],
//       ),
//     );
//   }
// }
