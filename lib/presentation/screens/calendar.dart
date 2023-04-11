import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/remainder.dart';
import 'package:mira_care/presentation/components/table_calendar/customization/calendar_style.dart';
import 'package:mira_care/presentation/components/table_calendar/table_calendar.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  var viewController = Get.put(ViewController());
  DateTime today = DateTime.now();
  DateTime currentDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late String focusedMonth;

  @override
  void initState() {
    super.initState();
    focusedMonth = DateFormat('MMMM yyyy').format(focusedDay);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;

    return GetBuilder<ViewController>(
      init: viewController,
      builder: (controller) {
        TextStyle calendarTextStyle = TextStyle(
          color: appColors.black,
          fontSize: 20.0 * fontScaleFactor,
        );
        TextStyle defaultStyle = TextStyle(
            color: appColors.black,
            fontSize: 20.0 * fontScaleFactor,
            fontWeight: FontWeight.w300);
        TextStyle selectedStyle = TextStyle(
          color: appColors.black,
          fontSize: 20.0 * fontScaleFactor,
          fontWeight: FontWeight.bold,
        );
        BoxDecoration todayDecoration = BoxDecoration(
          color: appColors.calendarAnc,
          shape: BoxShape.circle,
        );
        TextStyle weekEndStyle = TextStyle(
          color: appColors.weekend,
          fontSize: 20.0 * fontScaleFactor,
        );
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
            decoration: BoxDecoration(
              color: appColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            height: scrHeight * 0.2,
            child: Stack(
              children: [
                Positioned(
                  top: scrHeight * 0.03,
                  left: scrWidth * 0.05,
                  child: Text(
                    'Calendar',
                    style: TextStyle(
                      fontSize: 34 * fontScaleFactor,
                      color: appColors.scoreCardText,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  top: scrHeight * 0.02,
                  right: scrWidth * 0.05,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: scrHeight * 0.065,
                      width: scrHeight * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        color: appColors.scoreCardText,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 30 * fontScaleFactor,
                          weight: 18 * fontScaleFactor,
                          color: appColors.white,
                          opticalSize: 30 * fontScaleFactor,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: scrHeight * 0.08,
                  left: scrWidth * 0.05,
                  child: Container(
                    height: scrHeight * 0.5,
                    width: scrWidth * 0.9,
                    padding: EdgeInsets.zero,
                    child: TableCalendar(
                      headerVisible: true,
                      firstDay:
                          DateTime.utc(today.year - 1, today.month, today.day),
                      lastDay:
                          DateTime.utc(today.year + 10, today.month, today.day),
                      focusedDay: focusedDay,
                      currentDay: currentDay,
                      daysOfWeekHeight: scrHeight * 0.04 * fontScaleFactor,
                      onDaySelected: (selectedDay, focusedDay) {
                        this.focusedDay = focusedDay;
                        currentDay = selectedDay;
                        setState(() {});
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: todayDecoration,
                        todayDecoration: todayDecoration,
                        selectedTextStyle: selectedStyle,
                        todayTextStyle: calendarTextStyle,
                        defaultTextStyle: defaultStyle,
                        weekendTextStyle: weekEndStyle,
                        isTodayHighlighted: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: scrHeight * 0.005,
                  left: scrHeight * 0.025,
                  child: Container(
                    height: scrHeight * 0.3,
                    width: scrWidth * 0.9,
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 3,
                      padding: EdgeInsets.all(scrHeight * 0.005),
                      itemBuilder: (context, index) {
                        var remColors = [
                          appColors.remCol1,
                          appColors.remCol2,
                          appColors.remCol3,
                        ];
                        var remainderText =
                            'Doctor Shah Appointment at 4.00PM Assigned to Monica';
                        return Remainder(
                          remColors: remColors,
                          remainderText: remainderText,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
