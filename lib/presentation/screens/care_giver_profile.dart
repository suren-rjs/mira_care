import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/controller/user_controller.dart';
import 'package:mira_care/resources/controller/view_controller.dart';
import 'package:mira_care/resources/data/model/auth_user.dart';
import 'package:mira_care/resources/service/secure_storage.dart';
import 'package:mira_care/utils/app_utils.dart';

class CareGiverProfileInfo extends StatefulWidget {
  const CareGiverProfileInfo({super.key});

  @override
  State<StatefulWidget> createState() => _CareGiverProfileInfoState();
}

class _CareGiverProfileInfoState extends State<CareGiverProfileInfo> {
  bool isEditProfile = false;
  bool isNewUser = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController timeZoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController userTypeController = TextEditingController();

  void checkIfNewUser() async {
    isNewUser = await secureStorage.get('new-user') == '1';
    phoneController.text = await secureStorage.get('mobile') ?? '';
    userTypeController.text =
        await secureStorage.get('userType') ?? 'CareTaker';

    DateTime now = DateTime.now();
    String offset = now.timeZoneOffset.toString().split('.').first;
    String formattedOffset =
        'GMT${offset.startsWith('-') ? '-' : '+'}${offset.substring(0, 4)}';

    timeZoneController =
        TextEditingController(text: 'Central Standard Time ($formattedOffset)');

    isEditProfile = isNewUser;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkIfNewUser();
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
      child: GetBuilder<UserController>(
        init: Get.put(UserController()),
        builder: (controller) {
          AuthUser? currentUser = controller.currentUser;
          if (currentUser != null) {
            nameController.text = currentUser.name ?? '';
            emailController.text = currentUser.email ?? '';
            locationController.text = currentUser.address ?? '';
            phoneController.text = currentUser.phone ?? '';
            if (![null, ''].contains(currentUser.timeZone)) {
              timeZoneController.text = currentUser.timeZone!;
            }
            if (![null, ''].contains(currentUser.gender)) {
              genderController.text = currentUser.gender!;
            }
            if (![null, ''].contains(currentUser.userType)) {
              userTypeController.text = currentUser.userType!;
              secureStorage.add('userType', '${currentUser.userType}');
            }
            qualificationController.text = currentUser.qualification ?? '';
            ageController.text = currentUser.age ?? '';
          }
          return Container(
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
                        try {
                          setState(() async {
                            if (isEditProfile ||
                                await secureStorage.get('new-user') == '1') {
                              //  api call for profile save
                              AuthUser user = AuthUser(
                                address: locationController.text,
                                age: ageController.text,
                                uid: await secureStorage.get('uid'),
                                email: emailController.text,
                                gender: genderController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                qualification: qualificationController.text,
                                timeZone: timeZoneController.text,
                                id: currentUser?.id,
                                userType: await secureStorage.get('userType'),
                                communityChannelId:
                                    userTypeController.text == 'CareTaker'
                                        ? await secureStorage.get('uid')
                                        : '',
                              );
                              await controller.addUser(user);
                              // ignore: use_build_context_synchronously
                              await appUtils.showToast(context, "Profile updated");
                              await controller.getUserProfile();
                            }
                            setState(() {
                              isEditProfile = !isEditProfile;
                            });
                          });
                        } catch (e) {
                          debugPrint('Exception $e');
                        }
                      },
                      child: Container(
                        width: scrWidth * 0.1,
                        decoration: BoxDecoration(
                          color: appColors.msgPin,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
                  bottom: 0,
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
                            scrWidth,
                            'Name',
                            nameController,
                            isEditProfile,
                            false,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Email',
                            emailController,
                            isEditProfile,
                            false,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Phone',
                            phoneController,
                            isEditProfile,
                            true,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Timezone',
                            timeZoneController,
                            isEditProfile,
                            true,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Gender',
                            genderController,
                            isEditProfile,
                            false,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Location',
                            locationController,
                            isEditProfile,
                            false,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Qualification',
                            qualificationController,
                            isEditProfile,
                            false,
                          ),
                          columnWidget(
                            fontScaleFactor,
                            scrHeight,
                            scrWidth,
                            'Age',
                            ageController,
                            isEditProfile,
                            false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Column columnWidget(
    double fontScaleFactor,
    double scrHeight,
    double scrWidth,
    String title,
    TextEditingController controller,
    bool editProfile,
    bool isReadOnly,
  ) {
    List<String> items = ['Male', 'Female', 'Third gender'];
    String? selectedValue;
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
            ? (title == 'Gender')
                ? Container(
                    height: scrHeight * 0.07,
                    width: scrWidth,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(),
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  controller.text != ''
                                      ? controller.text
                                      : 'Select',
                                  style: TextStyle(
                                    fontSize: 16 * fontScaleFactor,
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
                                      fontSize: 16 * fontScaleFactor,
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
                              controller.text = selectedValue!;
                            });
                          },
                          buttonStyleData: ButtonStyleData(
                            height: scrHeight * 0.07,
                            width: scrWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal: scrWidth * 0.05,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: appColors.msgHintGray,
                              ),
                              color: appColors.white,
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
                            width: scrWidth * 0.825,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appColors.white,
                            ),
                            elevation: 1,
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all<double>(6),
                              thumbVisibility: MaterialStateProperty.all<bool>(
                                true,
                              ),
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.only(
                              left: 14,
                              right: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: scrHeight * 0.06,
                    child: TextField(
                      controller: controller,
                      readOnly: isReadOnly,
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
          controller.text,
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
