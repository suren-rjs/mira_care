import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/sleep_scale.dart';

class SleepCard extends StatelessWidget {
  const SleepCard({
    super.key,
    required this.title,
    required this.iconUri,
    required this.hour,
    required this.minutes,
    required this.sleepStart,
    required this.sleepEnd,
    required this.deepSleepStart,
    required this.deepSleepEnd,
    this.function,
  });

  final String title;
  final String iconUri;
  final int sleepStart;
  final int sleepEnd;
  final int deepSleepStart;
  final int deepSleepEnd;
  final String hour;
  final String minutes;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    double cardHeight = scrHeight * 0.165;
    double cardWidth = scrWidth * 0.9;
    double progressWidth = cardWidth * 0.9;
    return InkWell(
      onTap: function,
      child: Container(
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
              child: SleepScale(
                progressWidth: progressWidth,
                progressHeight: cardHeight,
                sleepStart: sleepStart,
                sleepEnd: sleepEnd,
                deepSleepStart: deepSleepStart,
                deepSleepEnd: deepSleepEnd,
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
      ),
    );
  }
}
