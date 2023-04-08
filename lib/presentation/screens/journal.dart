import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/screens/message_widget.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

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
                Positioned(
                  top: scrHeight * 0.02,
                  right: scrWidth * 0.05,
                  child: InkWell(
                    onTap: () {},
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
                ),
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
                  child: GetBuilder<NotesController>(
                    init: Get.put(NotesController()),
                    builder: (notesCtrl) {
                      return SizedBox(
                        height: scrHeight * 0.6,
                        width: scrWidth,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: notesCtrl.notesTotal,
                          itemBuilder: (context, index) {
                            return ReceivedMessage(msg: notesCtrl.notes[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: scrHeight * 0,
                  child: controller.journalPage == 0
                      ? Container(
                          height: scrHeight * 0.1,
                          width: scrWidth,
                          padding: EdgeInsets.symmetric(
                            vertical: scrWidth * 0.02,
                            horizontal: scrWidth * 0.02,
                          ),
                          margin: EdgeInsets.symmetric(
                            vertical: scrWidth * 0.02,
                            horizontal: scrWidth * 0.02,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: scrWidth * 0.125,
                                width: scrWidth * 0.125,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: appColors.msgPin,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Icon(
                                  Icons.attachment_rounded,
                                  size: 20 * fontScaleFactor,
                                ),
                              ),
                              Container(
                                height: scrWidth * 0.125,
                                width: scrWidth * 0.2,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: appColors.msgPin,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                    color: appColors.black,
                                    fontSize: 20 * fontScaleFactor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
