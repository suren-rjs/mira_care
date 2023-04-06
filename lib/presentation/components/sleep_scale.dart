import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class SleepScale extends StatelessWidget {
  const SleepScale({
    super.key,
    required this.progressWidth,
    required this.progressHeight,
    required this.sleepStart,
    required this.sleepEnd,
    required this.deepSleepStart,
    required this.deepSleepEnd,
    this.events,
  });

  final double progressWidth;
  final double progressHeight;
  final int sleepStart;
  final int sleepEnd;
  final int deepSleepStart;
  final int deepSleepEnd;
  final List<int>? events;

  @override
  Widget build(BuildContext context) {
    List<int> eventList = events ?? [22];
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
    return Row(
      children: [
        Container(
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          width: progressWidth,
          height: progressHeight * 0.2,
          color: appColors.nonSleep,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: 24,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              int eventTime =
                  (index >= 0 && index < 15 ? index + 9 : index - 15);
              int sleepStartTime = progressValues[sleepStart - 1];
              int sleepEndTime = progressValues[sleepEnd - 1];
              int deepSleepStartTime = progressValues[deepSleepStart - 1];
              int deepSleepEndTime = progressValues[deepSleepEnd - 1];
              bool isClockWise = sleepStartTime < sleepEndTime;
              var progressColor = (isClockWise
                      ? (index >= sleepStartTime && index <= sleepEndTime)
                      : (index >= sleepStartTime || index <= sleepEndTime))
                  ? index >= deepSleepStartTime && index <= deepSleepEndTime
                      ? appColors.deepSleep
                      : appColors.sleep
                  : appColors.nonSleep;
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0, color: progressColor),
                      color: progressColor,
                    ),
                    clipBehavior: Clip.none,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    width: progressWidth / 24,
                    height: progressHeight * 0.2,
                  ),
                  Positioned(
                    top: 10,
                    left: 2.5,
                    child: eventList.contains(eventTime)
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5, color: appColors.black),
                              borderRadius: BorderRadius.circular(25),
                              color: appColors.event,
                            ),
                            height: progressHeight * 0.06,
                            width: progressHeight * 0.06,
                          )
                        : Container(),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
