import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/data/model/message.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({
    super.key,
    required this.msg,
  });

  final Note msg;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    String date = DateFormat('MMMM d, h:mm a').format(msg.dateTime);
    var messageHeight = (scrHeight * msg.factor) * msg.contentHeightFactor;
    return Container(
      margin: EdgeInsets.symmetric(vertical: scrHeight * 0.005),
      width: scrHeight * 0.4,
      height: scrHeight * 0.0125 + messageHeight,
      child: Stack(
        children: [
          Positioned(
            bottom: scrHeight * 0.01,
            child: SizedBox(
              height: scrWidth * 0.1,
              width: scrWidth * 0.1,
              child: AvatarImage(url: msg.avatarImage),
            ),
          ),
          Positioned(
            bottom: scrHeight * -0.025,
            left: scrWidth * 0.15,
            child: SizedBox(
              height: scrWidth * 0.1,
              width: scrWidth * 0.7,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12 * fontScaleFactor,
                  color: appColors.msgTextGray,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: scrHeight * 0.03,
            left: scrWidth * 0.15,
            child: Container(
              decoration: BoxDecoration(
                color: appColors.messageGray,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              width: scrWidth * 0.69,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  msg.content,
                  style: TextStyle(
                    fontSize: 14 * fontScaleFactor,
                    color: appColors.black,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
