import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.iconUri,
    required this.name,
    this.function,
  });

  final String iconUri;
  final String name;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: scrHeight * 0.015),
      child: InkWell(
        onTap: () {
          if (function != null) {
            (function)!();
          }
          Get.back();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: scrWidth * 0.1,
              child: Image.asset(iconUri),
            ),
            SizedBox(width: scrWidth * 0.05),
            Text(
              name,
              style: TextStyle(
                color: appColors.overlayText,
                fontSize: 32 * fontScaleFactor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
