import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/event.dart';
import 'package:mira_care/resources/service/event_service.dart';

class EventController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<JournalEvent> _event = [];

  @override
  void onInit() {
    super.onInit();
    _event.clear();
    getEvents();
  }

  getEvents() async {
    _event.clear();
    await eventService.get().then((value) {
      _event = value;
      update();
    }).onError((error, stackTrace) {
      _event.clear();
      update();
    });
  }

  newEvent(JournalEvent event) async {
    await eventService.add(event);
    getEvents();
  }

  updateById(JournalEvent event) async {
    await eventService.update(event);
    getEvents();
  }

  delete(String id) async {
    await eventService.delete(id);
    getEvents();
  }

  List<JournalEvent> get events => _event;

  int get length => events.length;
}
