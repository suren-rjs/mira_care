import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/controller/view_controller.dart';

class CareGiverProfileInfo extends StatefulWidget {
  const CareGiverProfileInfo({super.key});

  @override
  State<StatefulWidget> createState() => _CareGiverProfileInfoState();
}

class _CareGiverProfileInfoState extends State<CareGiverProfileInfo> {
  bool isEditProfile = false;

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

    return WillPopScope(
      onWillPop: () async {
        Get.put(ViewController()).changeScreenView(1);
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
              top: scrHeight * 0.02,
              left: scrWidth * 0.05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 34 * fontScaleFactor,
                      color: appColors.scoreCardText,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Manage your information',
                    style: TextStyle(
                      fontSize: 16 * fontScaleFactor,
                      color: appColors.textGray,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: scrHeight * 0.05,
              right: scrWidth * 0.05,
              child: SizedBox(
                height: scrHeight * 0.05,
                width: scrHeight * 0.09,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (isEditProfile) {
                        //  api call for profile save
                      }
                      isEditProfile = !isEditProfile;
                    });
                  },
                  child: Container(
                    width: scrWidth * 0.1,
                    decoration: BoxDecoration(
                      color: appColors.msgPin,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Text(
                        isEditProfile ? 'Save' : 'Edit',
                        style: TextStyle(
                          color: appColors.black,
                          fontSize: 18 * fontScaleFactor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: scrHeight * 0.125,
                left: scrWidth * 0.05,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your care recipients',
                      style: TextStyle(
                        fontSize: 16 * fontScaleFactor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                        color: appColors.scoreCardText,
                      ),
                    ),
                    SizedBox(height: scrHeight * 0.025),
                    SizedBox(
                      width: scrWidth * 0.5,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 25,
                            child: SizedBox(
                              width: scrWidth * 0.1,
                              height: scrWidth * 0.1,
                              child: const AvatarImage(
                                url:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmInR4ljBH8rLmxngqj5KH5NIWJ6fdGtt8ow&usqp=CAU',
                              ),
                            ),
                          ),
                          Positioned(
                            child: SizedBox(
                              width: scrWidth * 0.1,
                              height: scrWidth * 0.1,
                              child: const AvatarImage(
                                url:
                                    'https://www.tensionends.com/wp-content/uploads/2022/09/Beautiful-Girl-DP-Images-1.jpg',
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 80,
                            child: Text(
                              '+3 more',
                              style: TextStyle(
                                fontSize: 16 * fontScaleFactor,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis,
                                color: appColors.fadeGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Positioned(
              top: scrHeight * 0.25,
              left: scrWidth * 0.05,
              child: SizedBox(
                width: scrHeight * 0.4,
                height: scrHeight * 0.625,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Name',
                        'Sophia Thomas',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Email',
                        'sophia.thomas@mirakare.com',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Phone',
                        '8673467832',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Timezone',
                        'Central Standard Time (GMT -6)',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Gender',
                        'Female',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Location',
                        'Robert Robertson, 1234 NW Bobcat Lane, St. Robert, MO 65584-5678',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Qualification',
                        'Masters in care giving',
                        isEditProfile,
                      ),
                      columnWidget(
                        fontScaleFactor,
                        scrHeight,
                        'Age',
                        '34',
                        isEditProfile,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column columnWidget(
    double fontScaleFactor,
    double scrHeight,
    String title,
    String value,
    bool editProfile,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20 * fontScaleFactor,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: scrHeight * 0.01),
        editProfile
            ? SizedBox(
                height: scrHeight * 0.06,
                child: TextField(
                  controller: TextEditingController(),
                  maxLines: 1,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    hintText: 'Enter $title',
                    hintStyle: TextStyle(
                      color: appColors.msgHintGray,
                      fontSize: 16 * fontScaleFactor,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              )
            : Text(
                value,
                style: TextStyle(
                  fontSize: 18 * fontScaleFactor,
                  fontWeight: FontWeight.normal,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
        SizedBox(height: scrHeight * 0.035),
      ],
    );
  }
}
