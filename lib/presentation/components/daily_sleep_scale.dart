import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/sleep_scale.dart';

class DailySleepScale extends StatelessWidget {
  const DailySleepScale({
    super.key,
    required this.duration,
    required this.sleepStart,
    required this.sleepEnd,
    required this.deepSleepStart,
    required this.deepSleepEnd,
  });

  final Duration duration;
  final int sleepStart;
  final int sleepEnd;
  final int deepSleepStart;
  final int deepSleepEnd;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: scrWidth * 0.05,
        vertical: scrHeight * 0.005,
      ),
      child: Column(
        children: [
          SleepScale(
            progressWidth: scrWidth * 0.9,
            progressHeight: scrHeight * 0.2,
            sleepStart: sleepStart,
            sleepEnd: sleepEnd,
            deepSleepStart: deepSleepStart,
            deepSleepEnd: deepSleepEnd,
            events: [sleepStart + 2],
          ),
          SizedBox(height: scrHeight * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9 AM',
                style: TextStyle(
                  fontSize: 13 * fontScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: appColors.white,
                ),
                maxLines: 1,
              ),
              Text(
                '20 Feb 2023 - ${duration.inHours}hr ${duration.inMinutes % 60}min',
                style: TextStyle(
                  fontSize: 13 * fontScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: appColors.white,
                ),
                maxLines: 1,
              ),
              Text(
                '9 AM',
                style: TextStyle(
                  fontSize: 13 * fontScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: appColors.white,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
