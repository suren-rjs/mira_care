import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/message.dart';

class MessagingController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  List<Message> _journalMessages = [];

  @override
  void onInit() {
    super.onInit();
    _journalMessages.clear();
  }

  List<Message> get notes => _journalMessages;

  int get notesTotal => notes.length;
}
