import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/screens/care_recipient_profile.dart';
import 'package:mira_care/presentation/screens/dashboard.dart';
import 'package:mira_care/presentation/screens/sleep_page.dart';

class ViewController extends GetxController {
  int _navigatorValue = 2;

  get navigatorValue => _navigatorValue;
  Widget currentScreen = const Dashboard();

  void setNavigatorValue(int num) => _changeSelectedValue(num);

  void _changeSelectedValue(int selectedValue) {
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
      case 3:
        break;
      case 4:
        break;
    }
    update();
  }
}
