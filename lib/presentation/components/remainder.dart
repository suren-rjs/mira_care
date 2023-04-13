import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/resources/data/model/calendar_remainder.dart';

class Remainder extends StatelessWidget {
  const Remainder({
    super.key,
    required this.remainder,
  });

  final CalendarRemainder remainder;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width * 0.9;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    double dateCardHeight = scrHeight * 0.1;
    var remColors = [
      appColors.remCol1,
      appColors.remCol2,
      appColors.remCol3,
      appColors.remCol4,
      appColors.remCol5,
      appColors.remCol6,
      appColors.remCol7,
      appColors.remCol8,
      appColors.remCol9,
      appColors.remCol10,
    ];
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.all(scrHeight * 0.005),
      decoration: BoxDecoration(
        color: appColors.backgroundGray,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      width: scrWidth * 0.9,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.only(
                right: (dateCardHeight - dateCardHeight * 0.95),
                left: 0,
                bottom: 0,
                top: 0),
            height: dateCardHeight,
            width: dateCardHeight,
            decoration: BoxDecoration(
              color: remColors[Random().nextInt(remColors.length)],
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Container(
              width: scrHeight * 0.05,
              decoration: BoxDecoration(
                color: appColors.white30,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: dateCardHeight * 0.25),
                  Center(
                    child: Text(
                      DateFormat('dd').format(remainder.dateTime!),
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 22 * fontScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: dateCardHeight * 0.02),
                  Center(
                    child: Text(
                      DateFormat('MMM').format(remainder.dateTime!),
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 10 * fontScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: dateCardHeight * 0.02),
                  Center(
                    child: Text(
                      DateFormat('hh:mm a').format(remainder.dateTime!),
                      style: TextStyle(
                        color: appColors.black,
                        fontSize: 14 * fontScaleFactor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: scrWidth * 0.05),
          Column(
            children: [
              SizedBox(
                width: scrWidth * 0.65,
                child: Text(
                  '${remainder.category}',
                  style: TextStyle(
                    fontSize: 14 * fontScaleFactor,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: scrWidth * 0.65,
                child: Text(
                  '${remainder.message}',
                  style: TextStyle(
                    fontSize: 14 * fontScaleFactor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
