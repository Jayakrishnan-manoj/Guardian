import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../constants/colors.dart';

class MiniCategoryCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback onPressed;
  const MiniCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.44,
        height: MediaQuery.sizeOf(context).height * 0.165,
        child: Container(
          decoration: BoxDecoration(
            color: tileColor,
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
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "32 pass",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: subTextColor, 
                          width: 1.5
                        )
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
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
  }
}
