import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/app_background.dart';
import 'package:mira_care/presentation/components/signIn_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        MediaQueryData contextSize = MediaQuery.of(context);
        double scrHeight = contextSize.size.height;
        double scrWidth = contextSize.size.width;
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
                              return Container();
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
