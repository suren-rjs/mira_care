import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class HealthScoreCard extends StatelessWidget {
  const HealthScoreCard({
    super.key,
    required this.title,
    required this.iconUri,
    required this.unit,
    required this.score,
  });

  final String title;
  final String iconUri;
  final String unit;
  final String score;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    double cardHeight = scrHeight * 0.165;
    double cardWidth = scrWidth * 0.45;
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: cardHeight * 0.075,
            left: cardWidth * 0.075,
            child: Text(
              title,
              style: TextStyle(
                color: appColors.black,
                fontSize: 14 * fontScaleFactor,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
          ),
          Positioned(
            top: cardHeight * 0.05,
            right: cardWidth * 0.05,
            child: SizedBox(
              height: cardHeight * 0.2,
              child: Image.asset(iconUri),
            ),
          ),
          Positioned(
            top: cardWidth * 0.3,
            child: SizedBox(
              width: cardWidth,
              child: Center(
                child: Text(
                  score,
                  style: TextStyle(
                    fontSize: 36 * fontScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: appColors.scoreCardText,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Positioned(
            top: cardWidth * 0.55,
            child: SizedBox(
              width: cardWidth,
              child: Center(
                child: Text(
                  unit,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16 * fontScaleFactor,
                    fontWeight: FontWeight.normal,
                    color: appColors.scoreCardText,
                  ),
                ),
              ),
            ),
          ),
          title == 'Heart Rate'
              ? Positioned(
                  left: cardWidth * 0,
                  bottom: cardHeight * 0,
                  child: Container(
                    height: cardHeight * 0.125,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      color: appColors.red,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}