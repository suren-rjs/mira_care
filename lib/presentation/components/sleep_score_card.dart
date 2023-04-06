import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class SleepScoreCard extends StatelessWidget {
  const SleepScoreCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      height: scrHeight * 0.25,
      width: scrWidth,
      padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.25),
      child: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/score.png'),
          ),
          Positioned(
            top: (scrHeight * 0.25) * 0.22,
            bottom: (scrHeight * 0.25) * 0.2,
            left: scrWidth * 0.1,
            right: scrWidth * 0.1,
            child: Center(
              child: Text(
                '76',
                style: TextStyle(
                  fontSize: 60 * fontScaleFactor,
                  color: appColors.scoreCardText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
