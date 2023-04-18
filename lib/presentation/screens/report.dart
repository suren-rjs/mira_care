import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/journal_event.dart';
import 'package:mira_care/presentation/components/vital_data.dart';
import 'package:mira_care/presentation/screens/message_widget.dart';
import 'package:mira_care/resources/controller/event_controller.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class Reporting extends StatefulWidget {
  const Reporting({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ReportingState();
}

class _ReportingState extends State<Reporting> {
  var viewController = Get.put(ViewController());

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

    DateTime now = DateTime.now();
    String today = DateFormat("MMM d").format(now);

    return GetBuilder<ViewController>(
      init: viewController,
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                height: scrHeight * 0.875,
                child: Stack(
                  children: [
                    Positioned(
                      top: scrHeight * 0.03,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: scrWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Report',
                                  style: TextStyle(
                                    fontSize: 34 * fontScaleFactor,
                                    color: appColors.scoreCardText,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: scrWidth * 0.15),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildReportButton(
                                      scrWidth,
                                      scrHeight,
                                      fontScaleFactor,
                                      'Day',
                                      () {},
                                    ),
                                    SizedBox(width: scrWidth * 0.01),
                                    buildReportButton(
                                      scrWidth,
                                      scrHeight,
                                      fontScaleFactor,
                                      'Week',
                                      () {},
                                    ),
                                    SizedBox(width: scrWidth * 0.01),
                                    buildReportButton(
                                      scrWidth,
                                      scrHeight,
                                      fontScaleFactor,
                                      'Month',
                                      () {},
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: scrHeight * 0.05),
                            Container(
                              decoration: BoxDecoration(
                                color: appColors.white,
                              ),
                              height: scrHeight * 0.75,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Vitals',
                                          style: TextStyle(
                                            color: appColors.textGray,
                                            fontSize: 24 * fontScaleFactor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: scrWidth * 0.225),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: appColors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            border: Border.all(
                                              color: appColors.borderGray,
                                              width: 1,
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(1),
                                          width: (scrWidth * 0.175),
                                          child: Center(
                                            child: Text(
                                              today,
                                              style: TextStyle(
                                                fontSize: 14 * fontScaleFactor,
                                                color: appColors.textGray,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: scrWidth * 0.175),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.share,
                                              color: appColors.black,
                                              size: 28 * fontScaleFactor,
                                            ),
                                            SizedBox(width: scrWidth * 0.005),
                                            Text(
                                              'Share',
                                              style: TextStyle(
                                                fontSize: 14 * fontScaleFactor,
                                                color: appColors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(width: scrWidth * 0.05),
                                      ],
                                    ),
                                    SizedBox(height: scrHeight * 0.05),
                                    const VitalData(
                                      imgUrl: 'assets/images/heart_rate.png',
                                      name: 'Heart Rate',
                                      unitText: '87 bpm to 133 bpm',
                                    ),
                                    const VitalData(
                                      imgUrl: 'assets/images/breath_rate.png',
                                      name: 'Breathing',
                                      unitText: '17 bpm to 21 bpm',
                                    ),
                                    const VitalData(
                                      imgUrl: 'assets/images/temp.png',
                                      name: 'Temperature',
                                      unitText: '97.3 F to 98.9 F',
                                    ),
                                    const VitalData(
                                      imgUrl:
                                          'assets/images/blood_pressure.png',
                                      name: 'Blood Pressure',
                                      unitText:
                                          '120 to 129mm Hg/ 74 to 80mm Hg',
                                    ),
                                    const VitalData(
                                      imgUrl: 'assets/images/oxy_level.png',
                                      name: 'Oxygen Level',
                                      unitText: '96% SpO2 to 99% SpO2',
                                    ),
                                    const VitalData(
                                      imgUrl: 'assets/images/glucose.png',
                                      name: 'Glucose',
                                      unitText: '98 mg/dl to 110 mg/dl',
                                    ),
                                    SizedBox(height: scrHeight * 0.03),
                                    Text(
                                      'Journal Notes',
                                      style: TextStyle(
                                        color: appColors.textGray,
                                        fontSize: 24 * fontScaleFactor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: scrHeight * 0.02),
                                    GetBuilder<NotesController>(
                                      init: Get.put(NotesController()),
                                      initState: (state) =>
                                          Get.put(NotesController())
                                              .getTodayNotes(),
                                      builder: (notesCtrl) {
                                        String emptyText = 'No notes to show !';
                                        return notesCtrl.notesTotal == 0
                                            ? emptyContainer(
                                                scrWidth,
                                                emptyText,
                                                fontScaleFactor,
                                              )
                                            : notesList(
                                                scrHeight,
                                                scrWidth,
                                                notesCtrl,
                                              );
                                      },
                                    ),
                                    SizedBox(height: scrHeight * 0.03),
                                    Text(
                                      'Journal Events',
                                      style: TextStyle(
                                        color: appColors.textGray,
                                        fontSize: 24 * fontScaleFactor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: scrHeight * 0.02),
                                    GetBuilder<EventController>(
                                      init: Get.put(EventController()),
                                      builder: (eventController) {
                                        String emptyText =
                                            'No events to show !';
                                        return eventController.length == 0
                                            ? emptyContainer(
                                                scrWidth,
                                                emptyText,
                                                fontScaleFactor,
                                              )
                                            : journalEvents(
                                                scrHeight,
                                                scrWidth,
                                                eventController,
                                              );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container journalEvents(
      double scrHeight, double scrWidth, EventController eventController) {
    return Container(
      padding: EdgeInsets.zero,
      height: scrHeight * 0.4,
      width: scrWidth * 0.9,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: eventController.length,
        itemBuilder: (context, index) {
          return JournalEventWidget(
            journalEvent: eventController.events[index],
          );
        },
      ),
    );
  }

  SizedBox notesList(
      double scrHeight, double scrWidth, NotesController notesCtrl) {
    return SizedBox(
      height: scrHeight * 0.4,
      width: scrWidth,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: notesCtrl.notesTotal,
        itemBuilder: (context, index) {
          return ReceivedMessage(
            note: notesCtrl.notes[index],
          );
        },
      ),
    );
  }

  Container emptyContainer(
      double scrWidth, String emptyText, double fontScaleFactor) {
    return Container(
      width: scrWidth,
      padding: EdgeInsets.symmetric(
        vertical: scrWidth * 0.05,
      ),
      child: Center(
        child: Text(
          emptyText,
          style: TextStyle(
            fontSize: 14 * fontScaleFactor,
            fontWeight: FontWeight.normal,
            color: appColors.textGray,
          ),
        ),
      ),
    );
  }

  InkWell buildReportButton(double scrWidth, double scrHeight,
      double fontScaleFactor, String text, Function() function) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(scrWidth * 0.025),
        height: scrHeight * (scrHeight < 750 ? 0.06 : 0.05),
        decoration: BoxDecoration(
          color: appColors.msgPin,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: appColors.black,
              fontSize: 18 * fontScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
