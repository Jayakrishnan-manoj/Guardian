import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        color: tileColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categoryIcon,
              Gap(15),
              Text(
                categoryTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "23 passwords",
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
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
