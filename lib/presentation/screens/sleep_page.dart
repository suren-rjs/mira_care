import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/add_remainder.dart';
import 'package:mira_care/presentation/components/care_recipient_profile_card.dart';
import 'package:mira_care/presentation/components/daily_sleep_scale.dart';
import 'package:mira_care/presentation/components/sleep_event.dart';
import 'package:mira_care/presentation/components/sleep_score_card.dart';
import 'package:mira_care/resources/controller/event_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';
import 'package:mira_care/resources/data/model/event.dart';

class SleepPage extends StatefulWidget {
  const SleepPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  var viewController = Get.put(ViewController());
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;

    return GetBuilder<ViewController>(
      init: viewController,
      builder: (controller) {
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
                            child: InkWell(
                              onTap: () {
                                _showMyDialog();
                              },
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
                          ),
                        ],
                      ),
                    ),
                    GetBuilder<EventController>(
                      init: Get.put(EventController()),
                      builder: (eventController) {
                        return Container(
                          padding: EdgeInsets.zero,
                          height: scrHeight * ((scrHeight < 750 ? 0.12 : 0.09) * eventController.length),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: eventController.length,
                            itemBuilder: (context, index) {
                              return SleepEvent(
                                journalEvent: eventController.events[index],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    TextEditingController remainderMessage = TextEditingController();
    TextEditingController currentDateTime =
        TextEditingController(text: DateFormat('dd-MM-yyyy ').format(today));
    TextEditingController selectedDateTime = TextEditingController();
    TextEditingController selectedCategory = TextEditingController();
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var buttonStyle = ElevatedButton.styleFrom(
          backgroundColor: appColors.scoreCardText,
        );
        return GetBuilder<EventController>(
          init: Get.put(EventController()),
          builder: (eventController) {
            return AlertDialog(
              title: Center(
                child: Text(
                  'Add Event',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: appColors.scoreCardText,
                  ),
                ),
              ),
              content: AddRemainder(
                remainderMessage: remainderMessage,
                currentDateTime: currentDateTime,
                selectedDateTime: selectedDateTime,
                selectedCategory: selectedCategory,
                isEvent: true,
              ),
              actionsPadding: EdgeInsets.only(
                right: scrWidth * 0.07,
                bottom: scrHeight * 0.02,
              ),
              actions: [
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    DateFormat format = DateFormat('dd-MM-yyyy HH:mm');
                    DateTime dateTime = format.parse(selectedDateTime.text);
                    eventController.newEvent(
                      JournalEvent(
                        category: selectedCategory.text,
                        dateTime: dateTime,
                        message: remainderMessage.text,
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}