import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/messages.dart';
import 'package:mira_care/presentation/components/new_note_input.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class Messaging extends StatefulWidget {
  const Messaging({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
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
                height: scrHeight * 0.15,
                child: Stack(
                  children: [
                    Positioned(
                      top: scrHeight * 0.03,
                      right: scrWidth * 0,
                      left: scrWidth * 0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: scrWidth * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Messaging',
                              style: TextStyle(
                                fontSize: 30 * fontScaleFactor,
                                color: appColors.scoreCardText,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: scrHeight * 0.02),
                            SizedBox(
                              height: scrHeight * 0.025,
                              width: scrWidth,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 5.75,
                                    bottom: 5.75,
                                    child: Container(
                                      width: scrWidth,
                                      height: scrHeight * 0.001,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: scrWidth * 0.05,
                                        vertical: scrWidth * 0.01,
                                      ),
                                      color: appColors.borderGray,
                                    ),
                                  ),
                                  Positioned(
                                    left: scrWidth * 0.25,
                                    right: scrWidth * 0.25,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: appColors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        border: Border.all(
                                          color: appColors.borderGray,
                                          width: 1,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(1),
                                      width: (scrWidth * 0.3),
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
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: appColors.white,
                ),
                height: scrHeight * 0.725,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: scrWidth * 0.05,
                      right: scrWidth * 0.05,
                      bottom: 0,
                      child: Column(
                        children: const [
                          Messages(),
                          NewNoteInput(
                            isMessageInput: true,
                          ),
                        ],
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
}
