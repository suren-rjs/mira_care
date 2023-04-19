import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/presentation/components/app_background.dart';
import 'package:mira_care/presentation/components/overlay_menu_row.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class OverlayPanel extends StatefulWidget {
  const OverlayPanel({super.key});

  @override
  State<StatefulWidget> createState() => _OverlayPanelState();
}

class _OverlayPanelState extends State<OverlayPanel> {
  @override
  void initState() {
    super.initState();
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
      init: Get.put(ViewController()),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              const AppBackground(),
              Container(
                height: scrHeight,
                width: scrWidth,
                color: Colors.black54,
              ),
              Positioned(
                top: scrHeight * 0.05,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: scrHeight * 0.01),
                  height: scrHeight * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: scrWidth * 0.25),
                      SizedBox(
                        width: scrWidth * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: scrWidth * 0.25,
                              height: scrHeight * 0.1,
                              child: Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: scrWidth * 0.1),
                      InkWell(
                        onTap: () => {Get.back()},
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24 * fontScaleFactor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: scrHeight * 0.15,
                left: scrWidth * 0.075,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.05),
                  height: scrHeight * 0.8,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(scrollbars: false),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MenuItem(
                            iconUri: 'assets/images/dash.png',
                            name: 'Dashboard',
                            function: () => controller.changeScreenView(1),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/journal.png',
                            name: 'Journal',
                            function: () => controller.changeScreenView(2),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/calendar.png',
                            name: 'Calendar',
                            function: () => controller.changeScreenView(3),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/community.png',
                            name: 'Community',
                            function: () => controller.changeScreenView(4),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/message.png',
                            name: 'Messaging',
                            function: () => controller.changeScreenView(5),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/contact.png',
                            name: 'Contacts',
                            function: () => controller.changeScreenView(6),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/reporting.png',
                            name: 'Reporting',
                            function: () => controller.changeScreenView(7),
                          ),
                          MenuItem(
                            iconUri: 'assets/images/analytics.png',
                            name: 'Analytics',
                            function: () {},
                          ),
                          MenuItem(
                            iconUri: 'assets/images/profile.png',
                            name: 'Profile',
                            function: () {},
                          ),
                          MenuItem(
                            iconUri: 'assets/images/settings.png',
                            name: 'Settings',
                            function: () {},
                          ),
                        ],
                      ),
                    ),
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
