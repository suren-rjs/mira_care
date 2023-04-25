import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/resources/service/secure_storage.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    super.key,
    required this.phoneNumber,
    this.function,
  });

  final TextEditingController phoneNumber;
  final Function()? function;

  @override
  State<StatefulWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  late final TextEditingController phoneNumber;
  late final Function()? function;

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.phoneNumber;
    function = widget.function;
    secureStorage.add('userType', 'CareTaker');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData contextSize = MediaQuery.of(context);
    double scrHeight = contextSize.size.height;
    double scrWidth = contextSize.size.width;
    final double fontScaleFactor = contextSize.textScaleFactor;
    BorderSide borderSide = BorderSide(width: 2, color: appColors.msgPin);
    List<String> userTypes = ['CareTaker', 'CareGiver'];
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: scrWidth * 0.55,
            child: ToggleSwitch(
              initialLabelIndex: 0,
              totalSwitches: 2,
              minWidth: scrWidth * 0.2725,
              labels: userTypes,
              inactiveBgColor: appColors.nonSleep,
              activeBgColor: [appColors.calendarAnc50],
              activeFgColor: appColors.black,
              onToggle: (index) async {
                if (index != null) {
                  await secureStorage.add(
                    'userType',
                    userTypes.elementAt(index),
                  );
                }
              },
            ),
          ),
          SizedBox(height: scrHeight * 0.02),
          SizedBox(
            height: scrHeight * 0.05,
            width: scrWidth * 0.55,
            child: TextField(
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLines: 1,
              controller: phoneNumber,
              decoration: InputDecoration(
                labelText: 'Mobile',
                prefixIcon: Icon(
                  Icons.phone_android_rounded,
                  color: appColors.msgPin,
                  size: 24.0 * fontScaleFactor,
                ),
                labelStyle: TextStyle(
                  color: appColors.textGray,
                  fontSize: 14 * fontScaleFactor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: borderSide,
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: borderSide,
                  borderRadius: BorderRadius.circular(5),
                ),
                hintText: 'Enter Mobile Number',
                hintStyle: TextStyle(
                  color: appColors.textGray,
                  fontSize: 14 * fontScaleFactor,
                ),
              ),
            ),
          ),
          SizedBox(height: scrHeight * 0.02),
          SizedBox(
            height: scrHeight * 0.045,
            width: scrWidth * 0.55,
            child: ElevatedButton(
              onPressed: function,
              style: ElevatedButton.styleFrom(
                elevation: 1,
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16 * fontScaleFactor,
                        fontWeight: FontWeight.w300,
                        color: appColors.white,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16 * fontScaleFactor,
                      weight: 300,
                      color: appColors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: scrHeight * 0.02),
          SizedBox(
            height: scrHeight * 0.001,
            child: Container(
              color: appColors.msgPin,
            ),
          ),
          SizedBox(height: scrHeight * 0.02),
          SignInButton(
            Buttons.GoogleDark,
            onPressed: () {},
          ),
          SignInButton(
            Buttons.AppleDark,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
