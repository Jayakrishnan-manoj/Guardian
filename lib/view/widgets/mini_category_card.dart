import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/controller/category_provider.dart';
import 'package:guardian/data/models/category_schema.dart';
import 'package:guardian/data/models/password_schema.dart';
import 'package:provider/provider.dart';

import '../constants/colors.dart';

class MiniCategoryCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final Categories category;
  final VoidCallback onPressed;
  const MiniCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, categoryProvider, _) {
      return StreamBuilder<CategorySchema>(
        stream: categoryProvider.watchCategoryCounts(),
        builder: (context, snapshot) {
          int passwordCount = 0;
          if (snapshot.hasData) {
            switch (category) {
              case Categories.browser:
                passwordCount = snapshot.data!.browserPasswords;
                break;
              case Categories.socialMedia:
                passwordCount = snapshot.data!.socialPasswords;
                break;
              case Categories.payments:
                passwordCount = snapshot.data!.paymentPasswords;
                break;
              case Categories.miscellaneous:
                passwordCount = snapshot.data!.miscellaneousPasswords;
                break;
            }
          }
          return GestureDetector(
            onTap: onPressed,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.44,
              height: MediaQuery.sizeOf(context).height * 0.165,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.tileColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      icon,
                      const Gap(20),
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$passwordCount passwords',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.subTextColor, width: 1.5)),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
