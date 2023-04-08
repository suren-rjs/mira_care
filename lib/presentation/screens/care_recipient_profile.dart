import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class CareRecipientProfileInfo extends StatelessWidget {
  const CareRecipientProfileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    String url =
        'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg';

    return WillPopScope(
      onWillPop: () async {
        Get.put(ViewController()).changeScreenView(1);
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: appColors.white,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 34 * fontScaleFactor,
                      color: appColors.scoreCardText,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Information about the care recipient',
                    style: TextStyle(
                      fontSize: 16 * fontScaleFactor,
                      color: appColors.textGray,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: scrHeight * 0.02,
              right: scrWidth * 0.05,
              child: SizedBox(
                height: scrHeight * 0.09,
                width: scrHeight * 0.09,
                child: InkWell(
                  onTap: () => {},
                  child: AvatarImage(url: url),
                ),
              ),
            ),
            Positioned(
              top: scrHeight * 0.15,
              left: scrWidth * 0.05,
              child: SizedBox(
                width: scrHeight * 0.4,
                height: scrHeight * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    columnWidget(fontScaleFactor, scrHeight, 'Name', 'Beth'),
                    columnWidget(
                        fontScaleFactor, scrHeight, 'Email', 'beth@gmail.com'),
                    columnWidget(
                        fontScaleFactor, scrHeight, 'Phone', '7658934523'),
                    columnWidget(fontScaleFactor, scrHeight, 'Timezone',
                        'Central Standard Time (GMT - 6)'),
                    columnWidget(
                        fontScaleFactor, scrHeight, 'Gender', 'Female'),
                    columnWidget(fontScaleFactor, scrHeight, 'Location',
                        'John Johnson, 4321 SW Tommy Wood Lane, St. Robert, MO 64367-8732'),
                    columnWidget(fontScaleFactor, scrHeight, 'Age', '19'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column columnWidget(
      double fontScaleFactor, double scrHeight, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20 * fontScaleFactor,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: scrHeight * 0.01),
        Text(
          value,
          style: TextStyle(
            fontSize: 18 * fontScaleFactor,
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 2,
        ),
        SizedBox(height: scrHeight * 0.035),
      ],
    );
  }
}
