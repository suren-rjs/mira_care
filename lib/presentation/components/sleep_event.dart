import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/resources/data/model/event.dart';

class SleepEvent extends StatelessWidget {
  const SleepEvent({
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: scrWidth * 0.6,
                  child: Text(
                    '${journalEvent.category}',
                    style: TextStyle(
                      fontSize: 14 * fontScaleFactor,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      color: appColors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: scrWidth * 0.01),
                SizedBox(
                  width: scrWidth * 0.6,
                  child: Text(
                    '${journalEvent.message}',
                    style: TextStyle(
                      color: appColors.white,
                      fontSize: 14 * fontScaleFactor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}