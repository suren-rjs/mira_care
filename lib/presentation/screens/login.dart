import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/app_background.dart';
import 'package:mira_care/presentation/components/otp_input_boxes.dart';
import 'package:mira_care/presentation/components/signin_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();
  ValueNotifier<bool> isSignInPage = ValueNotifier(true);
  ValueNotifier<int> timer = ValueNotifier(30);
  ValueNotifier<bool> isTimerCompleted = ValueNotifier(false);
  bool isTimerActivated = false;

  @override
  void initState() {
    super.initState();
  }

  void activateTimer() async {
    if (isTimerActivated) return;
    isTimerActivated = true;
    int count = 0;
    Timer.periodic(const Duration(seconds: 1), (seconds) {
      count++;
      timer.value = 30 - count;
      if (count == 30) {
        isTimerCompleted.value = true;
        seconds.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        MediaQueryData contextSize = MediaQuery.of(context);
        double scrHeight = contextSize.size.height;
        double scrWidth = contextSize.size.width;
        double fontScaleFactor = contextSize.textScaleFactor;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: appColors.white,
          body: Stack(
            children: [
              Positioned(
                top: scrHeight * 0,
                child: const AppBackground(),
              ),
              Positioned(
                top: scrHeight * 0.05,
                left: scrWidth * 0.35,
                right: scrWidth * 0.35,
                child: SizedBox(
                  width: scrWidth * 0.3,
                  height: scrHeight * 0.25,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Positioned(
                top: scrHeight * 0.25,
                left: scrWidth * 0.1,
                right: scrWidth * 0.1,
                child: Container(
                  height: scrHeight * 0.65,
                  width: scrWidth * 0.6,
                  decoration: BoxDecoration(
                    color: appColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: scrHeight * 0.265,
                        decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          'https://iiflinsurance.com/images/separate-health-plan.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: scrHeight * 0.04),
                      SizedBox(
                        height: scrHeight * 0.3,
                        child: ValueListenableBuilder(
                          valueListenable: isSignInPage,
                          builder: (context, value, child) {
                            if (value) {
                              return SignInWidget(
                                phoneNumber: phoneNumber,
                                isSignInPage: isSignInPage,
                              );
                            } else {
                              activateTimer();
                              return Column(
                                children: [
                                  OtpInputBoxes(otpController: otpController),
                                  SizedBox(height: scrHeight * 0.02),
                                  ValueListenableBuilder(
                                    valueListenable: isTimerCompleted,
                                    builder: (context, isCompleted, child) {
                                      return Column(
                                        children: [
                                          isCompleted
                                              ? Container()
                                              : ValueListenableBuilder(
                                                  valueListenable: timer,
                                                  builder:
                                                      (context, value, child) {
                                                    return Text(
                                                      'Resend code in $value Seconds',
                                                    );
                                                  },
                                                ),
                                          SizedBox(height: scrHeight * 0.02),
                                          SizedBox(
                                            height: scrHeight * 0.045,
                                            width: scrWidth * 0.55,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 1,
                                              ),
                                              child: Center(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Continue',
                                                      style: TextStyle(
                                                        fontSize: 16 *
                                                            fontScaleFactor,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: appColors.white,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size:
                                                          16 * fontScaleFactor,
                                                      weight: 300,
                                                      color: appColors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: scrHeight * 0.02),
                                          isCompleted
                                              ? InkWell(
                                                  onTap: () {},
                                                  child: Text(
                                                    'Resend OTP',
                                                    style: TextStyle(
                                                      color: appColors
                                                          .scoreCardText,
                                                      fontSize:
                                                          14 * fontScaleFactor,
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
