import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class SleepScoreCard extends StatelessWidget {
  const SleepScoreCard({
    super.key,
    required this.title,
    required this.iconUri,
    required this.hour,
    required this.minutes,
    required this.sleepStart,
    required this.sleepEnd,
    required this.deepSleepStart,
    required this.deepSleepEnd,
  });

  final String title;
  final String iconUri;
  final int sleepStart;
  final int sleepEnd;
  final int deepSleepStart;
  final int deepSleepEnd;
  final String hour;
  final String minutes;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    double cardHeight = scrHeight * 0.165;
    double cardWidth = scrWidth * 0.9;
    double progressWidth = cardWidth * 0.9;
    Map progressValues = {
      9: 1,
      10: 2,
      11: 3,
      12: 4,
      13: 5,
      14: 6,
      15: 7,
      16: 8,
      17: 9,
      18: 10,
      19: 11,
      20: 12,
      21: 13,
      22: 14,
      23: 15,
      0: 16,
      1: 17,
      2: 18,
      3: 19,
      4: 20,
      5: 21,
      6: 22,
      7: 23,
      8: 0,
    };
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
            left: cardWidth * 0.05,
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
            top: cardHeight * 0.3,
            left: cardWidth * 0.05,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  width: progressWidth,
                  height: cardHeight * 0.2,
                  color: appColors.nonSleep,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: 24,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      index += 1;
                      var progressColor =
                          index - 1 > progressValues[sleepStart] &&
                                  index - 1 < progressValues[sleepEnd]
                              ? index - 1 > progressValues[deepSleepStart] &&
                                      index - 1 < progressValues[deepSleepEnd]
                                  ? appColors.deepSleep
                                  : appColors.sleep
                              : appColors.nonSleep;
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: progressColor),
                          color: progressColor,
                        ),
                        clipBehavior: Clip.none,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        width: progressWidth / 24,
                        height: cardHeight * 0.2,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: cardHeight * 0.3,
            left: cardWidth * 0.05,
            child: SizedBox(
              height: cardHeight * 0.6,
              width: cardWidth * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '9 AM',
                    style: TextStyle(
                      fontSize: 14 * fontScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    '9 AM',
                    style: TextStyle(
                      fontSize: 14 * fontScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: cardWidth * 0.25,
            child: SizedBox(
              width: cardWidth,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: hour,
                    style: TextStyle(
                      fontSize: 36 * fontScaleFactor,
                      fontWeight: FontWeight.bold,
                      color: appColors.scoreCardText,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'hr ',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20 * fontScaleFactor,
                          color: appColors.scoreCardText,
                        ),
                      ),
                      TextSpan(
                        text: minutes,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 36 * fontScaleFactor,
                          color: appColors.scoreCardText,
                        ),
                      ),
                      TextSpan(
                        text: 'min',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20 * fontScaleFactor,
                          color: appColors.scoreCardText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
