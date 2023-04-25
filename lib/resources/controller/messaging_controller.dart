import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/resources/data/model/message.dart';
import 'package:mira_care/resources/service/messaging_service.dart';
import 'package:mira_care/resources/service/secure_storage.dart';

class MessagingController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  List<UserMessage> _communityMessages = [];

  String _channelId = '';

  @override
  void onInit() {
    super.onInit();
    _communityMessages.clear();
    getMessages();
  }

  setChannelId(String id) {
    _channelId = id;
    getMessages();
    update();
  }

  Future<void> getMessages() async {
    debugPrint('Called Get Messages');
    if (_channelId == '' &&
        (await secureStorage.get('userType') == 'CareTaker')) {
      _channelId = await secureStorage.get('uid') ?? '';
    }
    _communityMessages = await messagingService.get(_channelId);
    debugPrint('Messages ${_communityMessages.length}');
    update();
  }

  Future<void> addMessage(UserMessage message) async {
    await messagingService.add(message);
    await getMessages();
  }

  Future<void> updateMessage(UserMessage message) async {
    await messagingService.update(message);
    await getMessages();
  }

  Future<void> deleteMessage(String id) async {
    await messagingService.delete(id);
    await getMessages();
  }

  List<UserMessage> get messages => _communityMessages;

  int get messageTotal => messages.length;
}
