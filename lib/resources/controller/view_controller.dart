import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/screens/care_recipient_profile.dart';
import 'package:mira_care/presentation/screens/dashboard.dart';

class ViewController extends GetxController {
  int _navigatorValue = 2;

  get navigatorValue => _navigatorValue;
  Widget currentScreen = const Dashboard();

  void setNavigatorValue(int num) => _changeSelectedValue(num);

  void _changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        currentScreen = const Dashboard();
        break;
      case 1:
        currentScreen = const CareRecipientProfileInfo();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
    }
    update();
  }
}
