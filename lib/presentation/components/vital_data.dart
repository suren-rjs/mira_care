import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class VitalData extends StatelessWidget {
  const VitalData({
    super.key,
    required this.imgUrl,
    required this.name,
    required this.unitText,
  });

  final String imgUrl;
  final String name;
  final String unitText;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      height: scrHeight * 0.09,
      width: scrWidth,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            top: scrHeight * 0.01,
            left: scrWidth * 0.05,
            child: SizedBox(
              height: scrHeight * 0.045,
              width: scrHeight * 0.045,
              child: Image.asset(imgUrl),
            ),
          ),
          Positioned(
            top: scrHeight * 0.02,
            left: scrWidth * 0.2,
            child: SizedBox(
                height: scrHeight * 0.1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 20 * fontScaleFactor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    Text(
                      unitText,
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 16 * fontScaleFactor,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
