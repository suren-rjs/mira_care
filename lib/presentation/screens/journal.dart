import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/add_remainder.dart';
import 'package:mira_care/presentation/components/journal_event_list.dart';
import 'package:mira_care/presentation/components/new_note_input.dart';
import 'package:mira_care/presentation/components/note_list.dart';
import 'package:mira_care/resources/controller/event_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';
import 'package:mira_care/resources/data/model/event.dart';

class Journal extends StatefulWidget {
  const Journal({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
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

    return GetBuilder<ViewController>(
      init: viewController,
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            decoration: BoxDecoration(
              color: appColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            height: scrHeight * 0.2,
            child: Stack(
              children: [
                Positioned(
                  top: scrHeight * 0.03,
                  left: scrWidth * 0.05,
                  child: Text(
                    'Journal',
                    style: TextStyle(
                      fontSize: 34 * fontScaleFactor,
                      color: appColors.scoreCardText,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                controller.journalPage == 1
                    ? Positioned(
                        top: scrHeight * 0.02,
                        right: scrWidth * 0.05,
                        child: InkWell(
                          onTap: () {
                            _showMyDialog();
                          },
                          child: Container(
                            height: scrHeight * 0.065,
                            width: scrHeight * 0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                        color: appColors.scoreCardText,
                      ),
                      child: Center(
                              child: Icon(
                                Icons.add,
                                size: 30,
                                weight: 18,
                                color: appColors.white,
                                opticalSize: 30,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Positioned(
                  top: scrHeight * 0.1,
                  child: SizedBox(
                    width: scrWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.setJournalPage(0);
                          },
                          child: Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 21 * fontScaleFactor,
                              fontWeight: FontWeight.bold,
                              decoration: controller.journalPage == 0
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.setJournalPage(1);
                          },
                          child: Text(
                            'Events',
                            style: TextStyle(
                              fontSize: 21 * fontScaleFactor,
                              fontWeight: FontWeight.bold,
                              decoration: controller.journalPage == 1
                                  ? TextDecoration.underline
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: scrHeight * 0.15,
                  left: scrWidth * 0.05,
                  child: controller.journalPage == 0
                      ? const NoteList()
                      : const JournalEventList(),
                ),
                Positioned(
                  bottom: scrHeight * 0,
                  child: controller.journalPage == 0
                      ? const NewNoteInput()
                      : Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMyDialog() async {
    TextEditingController remainderMessage = TextEditingController();
    TextEditingController currentDateTime = TextEditingController(
        text: DateFormat('dd-MM-yyyy ').format(DateTime.now()));
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
