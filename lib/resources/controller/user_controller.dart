import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/components/loading_screen.dart';
import 'package:mira_care/resources/data/model/auth_user.dart';
import 'package:mira_care/resources/service/secure_storage.dart';
import 'package:mira_care/resources/service/user_service.dart';

class UserController extends GetxController {
  Widget currentScreen = const LoadingScreen(isInitCall: true);

  AuthUser? currentUser;

  UserController() {
    getUserProfile();
  }

  getUserProfile() async {
    String uid = await secureStorage.get('uid') ?? '';
    currentUser = await getUser(uid);
    if (currentUser != null) {
      await secureStorage.add('new-user', '0');
    }
    update();
  }

  Future<AuthUser?> getUser(String uid) async {
    return await userService.get(uid);
  }

  Future<void> addUser(AuthUser user) async {
    await userService.add(user);
  }

  Future<void> updateUser(AuthUser user) async {
    await userService.update(user);
  }

  Future<void> deleteUser(String id) async {
    await userService.delete(id);
  }
}
