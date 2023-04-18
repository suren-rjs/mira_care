import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/calendar_remainder.dart';
import 'package:mira_care/resources/service/calendar_remainder_service.dart';

class RemainderController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  int currentMonth = DateTime.now().month;

  List<CalendarRemainder> _calendarRemainder = [];
  List<int> eventDates = [];

  @override
  void onInit() {
    super.onInit();
    _calendarRemainder.clear();
    getMonthDates(DateTime.now().month);
    getTodayRemainders(DateTime.now());
  }

  Future<void> getMonthDates(int month) async {
    if (currentMonth == month) return;
    currentMonth = month;
    DateTime now = DateTime.now();
    DateTime monthStartDate = DateTime(now.year, month, 1);
    DateTime monthEndDate = DateTime(now.year, month + 1, 0);

    await remainderService
        .getRemainderDates(monthStartDate, monthEndDate)
        .then((value) {
      eventDates = value;
      update();
    }).onError((error, stackTrace) {
      eventDates.clear();
      update();
    });
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
