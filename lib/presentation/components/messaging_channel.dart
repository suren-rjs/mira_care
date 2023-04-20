import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/components/message_widget.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';
import 'package:mira_care/resources/data/model/journal_note.dart';
import 'package:mira_care/resources/data/model/message.dart';

class MessagingChannel extends StatefulWidget {
  const MessagingChannel({super.key});

  @override
  State<StatefulWidget> createState() => _MessagingChannelState();
}

class _MessagingChannelState extends State<MessagingChannel> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getLastNote();
  }

  getLastNote() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(microseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return GetBuilder<NotesController>(
      init: Get.put(NotesController()),
      builder: (msgCtrl) {
        getLastNote();
        List<String> userId = ['1212', '1221'];
        return SizedBox(
          height: scrHeight * 0.6,
          width: scrWidth,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: msgCtrl.notesTotal,
            itemBuilder: (context, index) {
              Note note = msgCtrl.notes[index];
              Message message = Message(
                dateTime: note.dateTime ?? DateTime.now(),
                senderId: userId[Random().nextInt(2)],
                channelName: 'channelName',
                message: '${note.content}',
                imageUri: '${note.avatarImage}',
              );
              return MessageWidget(message: message);
            },
          ),
        );
      },
    );
  }
}
