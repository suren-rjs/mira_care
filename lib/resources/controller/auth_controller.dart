import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/components/loading_screen.dart';
import 'package:mira_care/presentation/screens/home_page.dart';
import 'package:mira_care/presentation/screens/login.dart';
import 'package:mira_care/resources/service/secure_storage.dart';

class AuthController extends GetxController {
  Widget currentScreen = const LoadingScreen(isInitCall: true);

  AuthController() {
    getLoginStatus();
  }

  getLoginStatus() async {
    try {
      bool isAuthenticated = await secureStorage.get('login') == '1';
      await Future.delayed(const Duration(milliseconds: 500));
      currentScreen = isAuthenticated ? const MyHomePage() : const Login();
    } catch (e) {
      await secureStorage.add('login', '0');
      currentScreen = const Login();
    }
    update();
  }
}
