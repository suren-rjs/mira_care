import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/care_recipient_profile_card.dart';
import 'package:mira_care/presentation/components/daily_sleep_scale.dart';
import 'package:mira_care/presentation/components/sleep_event.dart';
import 'package:mira_care/presentation/components/sleep_score_card.dart';

class SleepPage extends StatelessWidget {
  const SleepPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CareRecipientProfileCard(
          isDashboard: false,
        ),
        SizedBox(
          height: scrHeight * 0.675,
          width: scrWidth,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                const SleepScoreCard(),
                Container(
                  padding: EdgeInsets.zero,
                  height: scrHeight * 0.4,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const DailySleepScale(
                        duration: Duration(hours: 10, minutes: 12),
                        sleepStart: 19,
                        sleepEnd: 6,
                        deepSleepStart: 20,
                        deepSleepEnd: 22,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.1,
                  child: Stack(
                    children: [
                      Positioned(
                        left: scrWidth * 0.05,
                        top: scrHeight * 0.02,
                        child: SizedBox(
                          width: scrWidth * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Events',
                                style: TextStyle(
                                  fontSize: 24 * fontScaleFactor,
                                  color: appColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Sleep Details',
                                style: TextStyle(
                                  fontSize: 16 * fontScaleFactor,
                                  color: appColors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: scrWidth * 0.05,
                        top: scrWidth * 0.05,
                        child: Container(
                          height: scrHeight * 0.05,
                          width: scrHeight * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: appColors.nonSleep,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 30,
                              weight: 18,
                              color: appColors.black,
                              opticalSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  height: scrHeight * (0.09 * 4),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return const SleepEvent();
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
