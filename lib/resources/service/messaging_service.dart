import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/resources/data/model/message.dart';

// ignore: library_private_types_in_public_api
_MessagingService messagingService = _MessagingService.instance;

class _MessagingService {
  _MessagingService._();

  final clientOptions = ably.ClientOptions(
    key: '132tjw.wBSWFA:GZRtApalfRgemPiY55x-cBf-jhnSKI1H3MvkG_eQkmw',
  );
  late final Realtime realtime;

  final _messagingChannel =
      FirebaseFirestore.instance.collection("CommunityChannel");
  final _communityMessages =
      FirebaseFirestore.instance.collection("CommunityMessages");

  init() async {
    realtime = ably.Realtime(options: clientOptions);
    realtime.connection
        .on(ably.ConnectionEvent.connected)
        .listen((ably.ConnectionStateChange stateChange) async {
      debugPrint('New state is: ${stateChange.current}');
      switch (stateChange.current) {
        case ably.ConnectionState.connected:
          // Successful connection
          debugPrint('Connected to Ably!');
          break;
        case ably.ConnectionState.failed:
          // Failed connection
          break;
        case ably.ConnectionState.initialized:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.connecting:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.disconnected:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.suspended:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.closing:
          // TODO: Handle this case.
          break;
        case ably.ConnectionState.closed:
          // TODO: Handle this case.
          break;
      }
    });
  }

  static final _MessagingService instance = _MessagingService._();

  subscribeToChannel(String channelName) async {
    final channel = realtime.channels.get(channelName);
    channel.subscribe().listen((message) {
      debugPrint(
          'Received a message in realtime from ${message.name}: ${message.data}');
      Get.snackbar(
        "New Message Received",
        "${message.data}",
        colorText: appColors.white,
        backgroundColor: appColors.scoreCardText,
        barBlur: 10.0,
      );
    });
  }

  sendMessage(String userName, String message, channelName) async {
    final channel = realtime.channels.get(channelName);
    await channel.publish(name: userName, data: message);
  }

  closeConnection() async {
    realtime.connection.close();
    realtime.connection
        .on(ably.ConnectionEvent.closed)
        .listen((ably.ConnectionStateChange stateChange) async {
      debugPrint('New state is: ${stateChange.current}');
      // ignore: missing_enum_constant_in_switch
      switch (stateChange.current) {
        case ably.ConnectionState.closed:
          debugPrint('Closed the connection to Ably.');
          break;
        case ably.ConnectionState.failed:
          break;
      }
    });
  }

  Future<List<UserMessage>> get(String id) async {
    List<UserMessage>? list = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _communityMessages
        .where('channelId', isEqualTo: id)
        .orderBy("dateTime", descending: false)
        .get();
    list = querySnapshot.docs
        .map((e) => UserMessage.fromJson(e.data(), e.id))
        .cast<UserMessage>()
        .toList();
    return list;
  }

  Future<bool> add(UserMessage message) async {
    await sendMessage(message.channelId, message.message, message.channelId);
    return await _communityMessages.add(message.toJson()).then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<void> addNewChannel(String channelId) async {
    _messagingChannel.doc(channelId).set({
      'channelId': channelId,
    });
  }

  Future<bool> update(UserMessage message) async {
    return await _communityMessages
        .doc(message.id)
        .update(message.toJson())
        .then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }

  Future<bool> delete(String id) async {
    return await _communityMessages.doc(id).delete().then((value) {
      return true;
    }).onError((error, stackTrace) {
      return false;
    });
  }
}
