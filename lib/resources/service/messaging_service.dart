import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:ably_flutter/ably_flutter.dart';
import 'package:flutter/material.dart';

// ignore: library_private_types_in_public_api
_MessagingService messagingService = _MessagingService.instance;

class _MessagingService {
  _MessagingService._();

  final clientOptions = ably.ClientOptions(
    key: '132tjw.wBSWFA:GZRtApalfRgemPiY55x-cBf-jhnSKI1H3MvkG_eQkmw',
  );
  late final Realtime realtime;

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
}
