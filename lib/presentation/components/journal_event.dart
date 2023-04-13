import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/data/model/event.dart';

class JournalEventWidget extends StatelessWidget {
  const JournalEventWidget({
    super.key,
    required this.journalEvent,
  });

  final JournalEvent journalEvent;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    double eventHeight = scrWidth * 0.17;
    var avatarUri =
        'https://www.tensionends.com/wp-content/uploads/2022/09/Beautiful-Girl-DP-Images-1.jpg';
    return Container(
      margin: EdgeInsets.symmetric(vertical: scrHeight * 0.005),
      width: scrWidth,
      height: scrHeight * 0.08,
      color: appColors.eventNote,
      child: Row(
        children: [
          Container(
            height: eventHeight,
            width: eventHeight,
            color: appColors.event,
            child: Column(
              children: [
                SizedBox(height: (eventHeight) * 0.1),
                Center(
                  child: Text(
                    DateFormat('dd').format(journalEvent.dateTime!),
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 22 * fontScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: (eventHeight) * 0.02),
                Center(
                  child: Text(
                    DateFormat('MMM').format(journalEvent.dateTime!),
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 10 * fontScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: (eventHeight) * 0.02),
                Center(
                  child: Text(
                    DateFormat('hh:mm a').format(journalEvent.dateTime!),
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 14 * fontScaleFactor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: scrWidth * 0.05),
          SizedBox(
            height: scrWidth * 0.1,
            width: scrWidth * 0.1,
            child: AvatarImage(url: avatarUri),
          ),
          SizedBox(width: scrWidth * 0.05),
          SizedBox(
            width: scrWidth * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${journalEvent.category}',
                  style: TextStyle(
                    color: appColors.white,
                    fontSize: 16 * fontScaleFactor,
                  ),
                ),
                Text(
                  '${journalEvent.message}',
                  style: TextStyle(
                    color: appColors.white,
                    fontSize: 12 * fontScaleFactor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
