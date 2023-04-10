

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/screens/message_widget.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return GetBuilder<NotesController>(
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
    );
  }
}