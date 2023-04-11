import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class Remainder extends StatelessWidget {
  const Remainder({
    super.key,
    required this.remColors,
    required this.remainderText,
  });

  final List<Color> remColors;
  final String remainderText;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width * 0.9;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    double dateCardHeight = scrHeight * 0.1;
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.all(scrHeight * 0.005),
      decoration: BoxDecoration(
        color: appColors.backgroundGray,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: scrWidth * 0.9,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                right: (dateCardHeight - dateCardHeight * 0.95),
                left: 0,
                bottom: 0,
                top: 0),
            height: dateCardHeight,
            width: dateCardHeight,
            decoration: BoxDecoration(
              color: remColors[Random().nextInt(remColors.length)],
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Container(
              width: scrHeight * 0.05,
              decoration: BoxDecoration(
                color: appColors.white30,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: dateCardHeight * 0.25),
                  Center(
                    child: Text(
                      '20',
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 22 * fontScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: dateCardHeight * 0.02),
                  Center(
                    child: Text(
                      'Feb',
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 10 * fontScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: dateCardHeight * 0.02),
                  Center(
                    child: Text(
                      '2:00 PM',
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 14 * fontScaleFactor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: scrWidth * 0.05),
          SizedBox(
            width: scrWidth * 0.65,
            child: Center(
              child: Text(
                remainderText,
                style: TextStyle(
                  fontSize: 14 * fontScaleFactor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
