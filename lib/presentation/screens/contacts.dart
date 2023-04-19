
import 'package:contacts_service/contacts_service.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
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
  final List<String> items = [
    'All Contacts',
    'Medical',
    'Caregivers',
    'Family',
    'Friends',
    'School',
    'Work',
    'Others',
  ];

  String? selectedValue = 'All Contacts';

  @override
  void initState() {
    super.initState();
    _contactLoader = _getContacts();
  }

  @override
  void dispose() {
    super.dispose();
    contactList.clear();
  }

  Future<List<UserContact>?> _getContacts() async {
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
      return [];
    }
  }

  Future<List<UserContact>> getContacts() async {
    final contacts = await ContactsService.getContacts();
    contactList.clear();
    for (var contact in contacts) {
      contactList.add(
        UserContact(
          name: '${contact.displayName ?? contact.phones?[0].value}',
          contact: '${contact.phones?[0].value}',
          jobTitle: contact.jobTitle ?? 'Others',
          image: contact.avatar,
        ),
      );
    }
    return contactList;
  }

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;

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
                            Container(
                              height: scrHeight * 0.07,
                              width: scrWidth * 0.8,
                              padding: const EdgeInsets.all(5),
                              child: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'All Contacts',
                                            style: TextStyle(
                                              fontSize: 18 * fontScaleFactor,
                                              fontWeight: FontWeight.bold,
                                              color: appColors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    items: items
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 18 * fontScaleFactor,
                                                fontWeight: FontWeight.bold,
                                                color: appColors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value as String;
                                        _getContacts();
                                      });
                                    },
                                    buttonStyleData: ButtonStyleData(
                                      height: scrHeight * 0.07,
                                      width: scrWidth,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: scrWidth * 0.05,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: appColors.dropdownGray,
                                        ),
                                        color: appColors.dropdownGray,
                                      ),
                                      elevation: 0,
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 28 * fontScaleFactor,
                                        color: appColors.black,
                                      ),
                                      iconSize: 14 * fontScaleFactor,
                                      iconEnabledColor: appColors.dropdownGray,
                                      iconDisabledColor: appColors.black25,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: scrHeight * 0.3,
                                      width: scrWidth * 0.8,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: appColors.dropdownGray,
                                      ),
                                      elevation: 1,
                                      scrollbarTheme: ScrollbarThemeData(
                                        radius: const Radius.circular(40),
                                        thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            MaterialStateProperty.all<bool>(
                                          true,
                                        ),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                child: FutureBuilder<List<UserContact>?>(
                  future: _contactLoader,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<UserContact>?> snapshot) {
                    if (snapshot.hasData) {
                      if (![null, 'All Contacts'].contains(selectedValue)) {
                        contactList = contactList
                            .where((contact) =>
                                '${contact.jobTitle?.toLowerCase()}' ==
                                '${selectedValue?.toLowerCase()}')
                            .toList();
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: contactList.length,
                        itemBuilder: (context, index) {
                          return CommunityContact(
                            contact: contactList[index],
                            isContacts: true,
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
