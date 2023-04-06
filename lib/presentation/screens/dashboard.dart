import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/care_recipient_profile_card.dart';
import 'package:mira_care/presentation/components/health_score_card.dart';
import 'package:mira_care/presentation/components/remainder.dart';
import 'package:mira_care/presentation/components/sleep_card.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    ViewController viewController = Get.put(ViewController());

    double reminderHeight = scrHeight * 0.11;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CareRecipientProfileCard(
          isDashboard: true,
        ),
        SizedBox(
          height: scrHeight * 0.675,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: scrHeight * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HealthScoreCard(
                      title: 'Heart Rate',
                      iconUri: 'assets/images/heart_rate.png',
                      score: '90',
                      unit: 'bpm',
                    ),
                    SizedBox(width: scrWidth * 0.02),
                    const HealthScoreCard(
                      title: 'Blood Pressure',
                      iconUri: 'assets/images/blood_pressure.png',
                      score: '143/90',
                      unit: 'mm Hg',
                    ),
                  ],
                ),
                SizedBox(height: scrHeight * 0.03),
                SleepCard(
                  title: 'Sleep',
                  iconUri: 'assets/images/sleep_rate.png',
                  hour: '10',
                  minutes: '34',
                  sleepStart: 21,
                  sleepEnd: 7,
                  deepSleepStart: 1,
                  deepSleepEnd: 1,
                  function: () => viewController.setNavigatorValue(12),
                ),
                SizedBox(height: scrHeight * 0.03),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HealthScoreCard(
                      title: 'Oxygen Level',
                      iconUri: 'assets/images/oxy_level.png',
                      score: '99',
                      unit: 'Spo2',
                    ),
                    SizedBox(width: scrWidth * 0.02),
                    const HealthScoreCard(
                      title: 'Breathing Rate',
                      iconUri: 'assets/images/breath_rate.png',
                      score: '18',
                      unit: 'pbm',
                    ),
                  ],
                ),
                SizedBox(height: scrHeight * 0.03),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const HealthScoreCard(
                      title: 'Temperature',
                      iconUri: 'assets/images/temp.png',
                      score: '98.7',
                      unit: 'F',
                    ),
                    SizedBox(width: scrWidth * 0.02),
                    const HealthScoreCard(
                      title: 'Glucose',
                      iconUri: 'assets/images/glucose.png',
                      score: '106',
                      unit: 'mg/dL',
                    ),
                  ],
                ),
                SizedBox(height: scrHeight * 0.03),
                const Center(
                  child: HealthScoreCard(
                    title: 'Weight',
                    iconUri: 'assets/images/weight.png',
                    score: '124',
                    unit: 'lbs',
                  ),
                ),
                SizedBox(height: scrHeight * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.05),
                  height: scrHeight * 0.03,
                  child: Row(
                    children: [
                      Text(
                        'Reminders',
                        style: TextStyle(
                          fontSize: 24 * fontScaleFactor,
                          color: appColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.05),
                  height: scrHeight * 0.03,
                  child: Row(
                    children: [
                      Text(
                        'Upcoming',
                        style: TextStyle(
                          fontSize: 16 * fontScaleFactor,
                          color: appColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: scrHeight * 0.02),
                Container(
                  padding: EdgeInsets.zero,
                  width: scrWidth,
                  height: (reminderHeight) * 3,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    padding: EdgeInsets.all(scrHeight * 0.005),
                    itemBuilder: (context, index) {
                      var remColors = [
                        appColors.remCol1,
                        appColors.remCol2,
                        appColors.remCol3,
                      ];
                      var remainderText =
                          'Doctor sha appointment at 4.00PM assigned to monica';
                      return Remainder(
                        remColors: remColors,
                        remainderText: remainderText,
                      );
                    },
                  ),
                ),
                SizedBox(height: scrHeight * 0.03),
              ],
            ),
          ),
        )
      ],
    );
  }
}
