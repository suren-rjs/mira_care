import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class CareRecipientProfileCard extends StatelessWidget {
  const CareRecipientProfileCard({
    super.key,
    required this.isDashboard,
  });

  final bool isDashboard;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    DateTime now = DateTime.now();
    String today = DateFormat("MMM d").format(now);
    String url =
        'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg';
    return WillPopScope(
      onWillPop: () async {
        Get.put(ViewController()).setNavigatorValue(1);
        return false;
      },
      child: GetBuilder<ViewController>(
        init: Get.put(ViewController()),
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  appColors.white,
                  appColors.transparent,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            height: scrHeight * 0.2,
            child: Stack(
              children: [
                Positioned(
                  top: scrHeight * 0.02,
                  left: scrWidth * 0.05,
                  child: Text(
                    'Beth',
                    style: TextStyle(
                      fontSize: 28 * fontScaleFactor,
                      color: appColors.scoreCardText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: scrHeight * 0.02,
                  right: scrWidth * 0.05,
                  child: SizedBox(
                    height: scrHeight * 0.09,
                    width: scrHeight * 0.09,
                    child: InkWell(
                      onTap: () => controller.setNavigatorValue(11),
                      child: AvatarImage(url: url),
                    ),
                  ),
                ),
                Positioned(
                  top: scrHeight * 0.11,
                  left: scrWidth * 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDashboard ? 'Vitals' : 'Sleep',
                        style: TextStyle(
                          fontSize: 24 * fontScaleFactor,
                          color: appColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        isDashboard ? 'Daily Reading' : 'Sleep Score',
                        style: TextStyle(
                          fontSize: 16 * fontScaleFactor,
                          color: appColors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: (scrWidth / 2) - (scrWidth * 0.05),
                  bottom: ((scrHeight * 0.2) / 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                        color: appColors.borderGray,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(1),
                    width: (scrWidth * 0.175),
                    child: Center(
                      child: Text(
                        today,
                        style: TextStyle(
                          fontSize: 14 * fontScaleFactor,
                          color: appColors.textGray,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
