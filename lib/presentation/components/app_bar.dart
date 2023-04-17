import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/presentation/components/overlay_panel.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Positioned(
      top: scrHeight * 0.05,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: scrHeight * 0.01),
        height: scrHeight * 0.07,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: scrWidth * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: scrWidth * 0.075),
                  SizedBox(
                    width: scrWidth * 0.1,
                    height: scrHeight * 0.1,
                    child: AvatarImage(url: url),
                  ),
                  SizedBox(width: scrWidth * 0.07),
                  SizedBox(
                    width: scrWidth * 0.25,
                    height: scrHeight * 0.1,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: scrWidth * 0.35),
            InkWell(
              onTap: () => {Get.to(() => const OverlayPanel())},
              child: Icon(
                Icons.density_medium_rounded,
                color: appColors.white,
                size: 24 * fontScaleFactor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
