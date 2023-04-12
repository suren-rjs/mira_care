import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/screens/message_widget.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';

class NoteList extends StatefulWidget {
  const NoteList({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
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
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return GetBuilder<NotesController>(
      init: Get.put(NotesController()),
      builder: (notesCtrl) {
        getLastNote();
        return SizedBox(
          height: scrHeight * 0.6,
          width: scrWidth,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: notesCtrl.notesTotal,
            itemBuilder: (context, index) {
              return ReceivedMessage(note: notesCtrl.notes[index]);
            },
          ),
        );
      },
    );
  }
}