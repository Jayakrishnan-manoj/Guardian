import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guardian/view/constants/colors.dart';

class SwitchTile extends StatelessWidget {
  bool parameter;
  final String switchText;
  void Function(bool) onChanged;

  SwitchTile({
    super.key,
    required this.parameter,
    required this.switchText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.tileColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            switchText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          CupertinoSwitch(
            activeColor: AppColors.blueAppColor,
            value: parameter,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}