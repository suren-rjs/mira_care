import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/app_background.dart';
import 'package:mira_care/presentation/components/otp_input_boxes.dart';
import 'package:mira_care/presentation/components/signin_widget.dart';
import 'package:mira_care/presentation/screens/home_page.dart';
import 'package:mira_care/resources/controller/view_controller.dart';
import 'package:mira_care/resources/data/model/auth_user.dart';
import 'package:mira_care/resources/service/secure_storage.dart';
import 'package:mira_care/resources/service/user_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();
  ValueNotifier<bool> isOtpSend = ValueNotifier(true);
  ValueNotifier<int> timer = ValueNotifier(30);
  ValueNotifier<bool> isTimerCompleted = ValueNotifier(false);
  bool isTimerActivated = false;
  bool isResendEnabled = true;

  String verificationId = '';
  String smsCode = '';
  int? resendToken;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  sendOtpToMobileNumber() async {
    debugPrint('Sending.... ${phoneNumber.text}');
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91 ${phoneNumber.text}',
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = '${credential.smsCode}';
        debugPrint("SMS Code ${credential.smsCode}");
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("SMS Code $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
          this.resendToken = resendToken;
        });
      },
      timeout: const Duration(seconds: 30),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyCode(String userCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: userCode,
    );
    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    if (userCredential.user != null) {
      await secureStorage.add("uid", userCredential.user?.uid ?? "");
      await secureStorage.add('login', '1');
      AuthUser? userInfo =
          await userService.get(userCredential.user?.uid ?? '');
      if (userInfo == null) {
        secureStorage.add('new-user', '1');
        Get.put(ViewController()).changeScreenView(13);
      } else {
        secureStorage.add('new-user', '0');
      }

      Get.to(
        () => const MyHomePage(),
      );
    } else {
      debugPrint('Error No User Credential Found');
    }
  }

  void resendOTP() async {}

  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.setSettings(forceRecaptchaFlow: false);
    firebaseAuth.signInAnonymously();
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
        return WillPopScope(
          onWillPop: () async {
            setState(() {
              isOtpSend.value = true;
            });
            return false;
          },
          child: Scaffold(
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
                            valueListenable: isOtpSend,
                            builder: (context, value, child) {
                              if (value) {
                                return SignInWidget(
                                  phoneNumber: phoneNumber,
                                  function: () async {
                                    await sendOtpToMobileNumber();
                                    isOtpSend.value = false;
                                  },
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
                                                    builder: (context, value,
                                                        child) {
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
                                                onPressed: () async {
                                                  if (otpController.text !=
                                                      '') {
                                                    await verifyCode(
                                                      otpController.text,
                                                    );
                                                  } else {
                                                    debugPrint(
                                                      'Sms Code $smsCode, OTP : ${otpController.text}',
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 1,
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                          color:
                                                              appColors.white,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size: 16 *
                                                            fontScaleFactor,
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
                                                    onTap: () {
                                                      if (isResendEnabled) {
                                                        setState(() {
                                                          isResendEnabled =
                                                              false;
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      'Resend OTP',
                                                      style: TextStyle(
                                                        color: isResendEnabled
                                                            ? appColors
                                                                .scoreCardText
                                                            : appColors
                                                                .textGray,
                                                        fontSize: 14 *
                                                            fontScaleFactor,
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
          ),
        );
      },
    );
  }
}
