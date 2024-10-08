import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:guardian/view/constants/colors.dart';

class CategoryCard extends StatelessWidget {
  final String categoryTitle;
  final Widget categoryIcon;
  const CategoryCard(
      {super.key, required this.categoryTitle, required this.categoryIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.483,
      height: MediaQuery.sizeOf(context).height * 0.2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
         
        ),
        color: AppColors.tileColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categoryIcon,
              const Gap(15),
              Text(
                categoryTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "23 passwords",
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.forward,
                      color: Colors.white60,
                    ),
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
