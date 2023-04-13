import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/components/journal_event.dart';
import 'package:mira_care/resources/controller/event_controller.dart';

class JournalEventList extends StatelessWidget {
  const JournalEventList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    return GetBuilder<EventController>(
      init: Get.put(EventController()),
      builder: (eventController) {
        return Container(
          padding: EdgeInsets.zero,
          height: scrHeight * 0.7,
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
      },
    );
  }
}
