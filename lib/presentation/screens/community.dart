import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/presentation/components/community_contact.dart';
import 'package:mira_care/resources/controller/view_controller.dart';
import 'package:mira_care/resources/data/model/user_contact.dart';

class Community extends StatefulWidget {
  const Community({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  var viewController = Get.put(ViewController());
  List<UserContact> contactList = [
    UserContact(
      name: 'John Burke',
      contact: '9876543210',
      imageUri:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzHQv_th9wq3ivQ1CVk7UZRxhbPq64oQrg5Q&usqp=CAU',
      relation: 'Beth\'s Father',
    ),
    UserContact(
      name: 'Sara Burke',
      contact: '9876543210',
      imageUri:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR47eGNB4uktvhbGIeWWDPNl-0L1EBWByWRkg&usqp=CAU',
      relation: 'Beth\'s Mother',
    ),
    UserContact(
      name: 'Liz Burke',
      contact: '9876543210',
      imageUri:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80',
      relation: 'Beth\'s Sister',
    ),
    UserContact(
      name: 'Monica',
      contact: '9876543210',
      imageUri:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSoQFvYAr4KD4S-iecBnmLmPf7zuyFyHkd8w&usqp=CAU',
    ),
    UserContact(
      name: 'Kris',
      contact: '9876543210',
      imageUri:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4rTZQtYuv-8nlbcVxhj3ptBBgp9d1OW8MOgN_CJhUsYkz8eb-Wu2v7dW58Z2a20G9J9I&usqp=CAU',
    ),
  ];

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
    String url =
        'https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg';

    return GetBuilder<ViewController>(
      init: viewController,
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: [
              Container(
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
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: scrWidth * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Community',
                              style: TextStyle(
                                fontSize: 34 * fontScaleFactor,
                                color: appColors.scoreCardText,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: scrHeight * 0.02),
                            Row(
                              children: [
                                SizedBox(
                                  width: scrWidth * 0.15,
                                  height: scrWidth * 0.15,
                                  child: AvatarImage(url: url),
                                ),
                                SizedBox(width: scrWidth * 0.05),
                                SizedBox(
                                  width: scrWidth * 0.65,
                                  child: Text(
                                    'View and communicate with people related to the care recipient',
                                    style: TextStyle(
                                      fontSize: 18 * fontScaleFactor,
                                      color: appColors.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 3,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColors.white,
                      appColors.transparent,
                    ],
                  ),
                ),
                height: scrHeight * 0.675,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: contactList.length,
                  itemBuilder: (context, index) {
                    return CommunityContact(
                      contact: contactList[index],
                      isContacts: false,
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
