import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../customization/header_style.dart';
import '../shared/utils.dart' show CalendarFormat, DayBuilder;

class CalendarHeader extends StatelessWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;

  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    final text = headerStyle.titleTextFormatter?.call(focusedMonth, locale) ??
        DateFormat.yMMMM(locale).format(focusedMonth);

    return Container(
      decoration: headerStyle.decoration,
      margin: headerStyle.headerMargin,
      padding: headerStyle.headerPadding,
      child: Container(
        width: scrWidth,
        padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.05),
        margin: EdgeInsets.symmetric(vertical: scrHeight * 0.025),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: onLeftChevronTap,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20 * fontScaleFactor,
                  ),
                ),
                SizedBox(width: scrWidth * 0.015),
                GestureDetector(
                  onTap: onHeaderTap,
                  onLongPress: onHeaderLongPress,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 21 * fontScaleFactor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: headerStyle.titleCentered
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  height: scrHeight * 0.025,
                  width: scrHeight * 0.025,
                  child: Center(
                    child: Image.asset(
                      'assets/images/calendar_img.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(width: scrWidth * 0.05),
                SizedBox(
                  height: scrHeight * 0.025,
                  width: scrHeight * 0.025,
                  child: Center(
                    child: Image.asset(
                      'assets/images/search_img.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
