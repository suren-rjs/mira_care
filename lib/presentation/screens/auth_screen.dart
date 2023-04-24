import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/controller/auth_controller.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: Get.put(AuthController()),
      builder: (controller) => controller.currentScreen,
    );
  }
}
