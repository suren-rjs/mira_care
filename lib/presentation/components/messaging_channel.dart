import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/components/message_widget.dart';
import 'package:mira_care/resources/controller/messaging_controller.dart';
import 'package:mira_care/resources/data/model/message.dart';
import 'package:mira_care/resources/service/secure_storage.dart';

class MessagingChannel extends StatefulWidget {
  const MessagingChannel({super.key});

  @override
  State<StatefulWidget> createState() => _MessagingChannelState();
}

class _MessagingChannelState extends State<MessagingChannel> {
  final ScrollController _scrollController = ScrollController();
  String channelId = '';

  @override
  void initState() {
    super.initState();
    getLastMessage();
    getChannelId();
  }

  getChannelId() async {
    channelId = await secureStorage.get('uid') ?? '';
    Get.find<MessagingController>().setChannelId(channelId);
  }

  getLastMessage() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(microseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;

    return GetBuilder<MessagingController>(
      init: Get.find<MessagingController>(),
      builder: (msgCtrl) {
        getLastMessage();
        return SizedBox(
          height: scrHeight * 0.6,
          width: scrWidth,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: msgCtrl.messageTotal,
            itemBuilder: (context, index) {
              UserMessage message = msgCtrl.messages[index];
              return MessageWidget(message: message);
            },
          ),
        );
      },
    );
  }
}
