import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/screens/care_recipient_profile.dart';
import 'package:mira_care/presentation/screens/dashboard.dart';
import 'package:mira_care/presentation/screens/journal.dart';
import 'package:mira_care/presentation/screens/sleep_page.dart';

class ViewController extends GetxController {
  Widget currentScreen = const Dashboard();
  int _navigatorValue = 1;
  int _journalPage = 0;

  get navigatorValue => _navigatorValue;

  get journalPage => _journalPage;

  void setJournalPage(int num) => _changeJournalPage(num);

  void changeScreenView(int num) => _changeMainScreenView(num);

  void _changeJournalPage(int num) {
    _journalPage = num;
    update();
  }

  void _changeMainScreenView(int selectedValue) {
    _navigatorValue = selectedValue;
    debugPrint('$selectedValue');
    switch (selectedValue) {
      case 1:
        currentScreen = const Dashboard();
        break;
      case 11:
        currentScreen = const CareRecipientProfileInfo();
        break;
      case 12:
        currentScreen = const SleepPage();
        break;
      case 2:
        _journalPage = 0;
        currentScreen = const Journal();
        break;
      case 4:
        break;
    }
    update();
  }
}
