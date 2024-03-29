import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/app_background.dart';
import 'package:mira_care/presentation/components/app_bar.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double scrHeight = mediaQuery.size.height;
    double textScaleFactor = mediaQuery.textScaleFactor;
    bool isMobile = mediaQuery.size.width <= 430;
    String url =
        'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg';
    return isMobile
        ? GetBuilder<ViewController>(
            init: Get.put(ViewController()),
            builder: (controller) {
              return Scaffold(
                body: Stack(
                  children: [
                    const AppBackground(),
                    CustomAppBar(url: url),
                    Positioned(
                      top: scrHeight * 0.125,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: controller.currentScreen,
                    ),
                  ],
                ),
              );
            },
          )
        : Center(
            child: Text(
              'Use mobile view for better experience',
              style: TextStyle(
                color: appColors.black,
                fontSize: 18 * textScaleFactor,
                decoration: TextDecoration.none,
              ),
            ),
          );
  }
}
