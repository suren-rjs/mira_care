import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class AddRemainder extends StatefulWidget {
  const AddRemainder({
    super.key,
    required this.remainderMessage,
  });

  final TextEditingController remainderMessage;

  @override
  State<StatefulWidget> createState() => _AddRemainderState();
}

class _AddRemainderState extends State<AddRemainder> {
  Time time = Time(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
    second: 00,
  );
  final List<String> items = [
    'Observations',
    'Meals',
    'Medication',
    'Toileting',
  ];
  String? selectedValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTimeChanged(Time newTime) {
    setState(() {
      time = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    String timeText =
        '${time.hour < 10 ? '0${time.hour}' : time.hour} : ${time.minute < 10 ? '0${time.minute}' : time.minute}';

    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: appColors.textGray,
      ),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: scrHeight * 0.07,
            width: scrWidth * 0.625,
            child: TextField(
              controller: widget.remainderMessage,
              maxLines: 2,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                enabledBorder: inputBorder,
                focusedBorder: inputBorder,
                errorBorder: inputBorder,
                hintText: 'Remainder Message',
              ),
            ),
          ),
          Container(
            height: scrHeight * 0.07,
            padding: const EdgeInsets.all(5),
            child: Center(
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Select Category',
                          style: TextStyle(
                            fontSize: 14 * fontScaleFactor,
                            color: appColors.dropDownText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 14 * fontScaleFactor,
                                color: appColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                    height: scrHeight * 0.07,
                    width: scrWidth * 0.625,
                    padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: appColors.msgInBorderGray,
                      ),
                      color: appColors.white,
                    ),
                    elevation: 0,
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 22 * fontScaleFactor,
                      color: appColors.textGray,
                    ),
                    iconSize: 14 * fontScaleFactor,
                    iconEnabledColor: appColors.white,
                    iconDisabledColor: Colors.grey,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: scrHeight * 0.3,
                    width: scrWidth * 0.625,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appColors.white,
                    ),
                    elevation: 2,
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                    padding: EdgeInsets.only(left: 14, right: 14),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: scrHeight * 0.07,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: time,
                    onChange: onTimeChanged,
                    minuteInterval: TimePickerInterval.FIVE,
                    onChangeDateTime: (DateTime dateTime) {
                      time = Time(
                        hour: dateTime.hour,
                        minute: dateTime.minute,
                        second: 00,
                      );
                      setState(() {});
                    },
                  ),
                );
              },
              child: Container(
                width: scrWidth * 0.6,
                color: appColors.white,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: time,
                          onChange: onTimeChanged,
                          minuteInterval: TimePickerInterval.FIVE,
                          onChangeDateTime: (DateTime dateTime) {
                            time = Time(
                              hour: dateTime.hour,
                              minute: dateTime.minute,
                              second: 00,
                            );
                            setState(() {});
                          },
                        ),
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timelapse_rounded,
                          color: appColors.scoreCardText75,
                          size: 34 * fontScaleFactor,
                        ),
                        SizedBox(
                          width: scrWidth * 0.025,
                        ),
                        Text(
                          timeText,
                          style: TextStyle(
                            fontSize: 28 * fontScaleFactor,
                            fontWeight: FontWeight.bold,
                            color: appColors.dropDownText,
                          ),
                        ),
                      ],
                    ),
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
