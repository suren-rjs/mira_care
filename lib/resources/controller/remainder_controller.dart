import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/calendar_remainder.dart';
import 'package:mira_care/resources/service/calendar_remainder_service.dart';

class RemainderController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CalendarRemainder> _calendarRemainder = [];

  @override
  void onInit() {
    super.onInit();
    _calendarRemainder.clear();
    getTodayRemainders(DateTime.now());
  }

  getRemainder() async {
    _calendarRemainder.clear();
    DateTime currentDate = DateTime.now();
    await remainderService
        .get(DateTime(currentDate.year, currentDate.month, currentDate.day))
        .then((value) {
      _calendarRemainder = value;
      update();
    }).onError((error, stackTrace) {
      _calendarRemainder.clear();
      update();
    });
  }

  getTodayRemainders(DateTime dateTime) async {
    _calendarRemainder.clear();
    await remainderService.get(dateTime).then((value) {
      _calendarRemainder = value;
      update();
    }).onError((error, stackTrace) {
      _calendarRemainder.clear();
      update();
    });
  }

  newRemainder(CalendarRemainder remainder) async {
    await remainderService.add(remainder);
    getRemainder();
  }

  updateById(CalendarRemainder remainder) async {
    await remainderService.update(remainder);
    getRemainder();
  }

  delete(String id) async {
    await remainderService.delete(id);
    getRemainder();
  }

  List<CalendarRemainder> get remainder => _calendarRemainder;

  int get length => remainder.length;
}
