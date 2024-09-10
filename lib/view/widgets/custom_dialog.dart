import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import 'mini_category_card.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.transparent.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  const Gap(10),
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
              const Gap(10),
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
                  const Gap(10),
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
          ),
        ),
      ),
    );
  }
}
