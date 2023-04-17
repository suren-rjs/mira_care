import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/presentation/components/community_contact.dart';
import 'package:mira_care/resources/controller/view_controller.dart';
import 'package:mira_care/resources/data/model/user_contact.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  const Contacts({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  var viewController = Get.put(ViewController());
  List<UserContact> contactList = [];
  late Future<List<UserContact>?> _contactLoader;

  @override
  void initState() {
    super.initState();
    _contactLoader = _getPermission();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<UserContact>?> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      if (permissionStatus[Permission.contacts] == PermissionStatus.granted ||
          permissionStatus[Permission.contacts] == PermissionStatus.limited) {
        return await getContacts();
      } else {
        return [];
      }
    } else if (permission == PermissionStatus.granted ||
        permission == PermissionStatus.limited) {
      return await getContacts();
    } else {
      debugPrint('Status $permission');
      return [];
    }
  }

  Future<List<UserContact>> getContacts() async {
    final contacts = await ContactsService.getContacts();
    for (var contact in contacts) {
      contactList.add(UserContact(
          name: '${contact.givenName ?? contact.phones?[0].value}',
          contact: '${contact.phones?[0].value}'));
    }
    debugPrint('Total Contacts ${contactList.length}');
    return contactList;
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
                              'Contacts',
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
                                  width: scrWidth * 0.125,
                                  height: scrWidth * 0.125,
                                  child: AvatarImage(url: url),
                                ),
                                SizedBox(width: scrWidth * 0.05),
                                SizedBox(
                                  width: scrWidth * 0.6,
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
              FutureBuilder<List<UserContact>?>(
                future: _contactLoader,
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserContact>?> snapshot) {
                  if (snapshot.hasData) {
                    debugPrint('${snapshot.data}');
                    return Container(
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
                            isContacts: true,
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
