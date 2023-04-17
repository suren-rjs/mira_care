import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/data/model/user_contact.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityContact extends StatelessWidget {
  const CommunityContact({
    super.key,
    required this.contact,
    required this.isContacts,
  });

  final UserContact contact;
  final bool isContacts;

  @override
  Widget build(BuildContext context) {
    double scrHeight = MediaQuery.of(context).size.height;
    double scrWidth = MediaQuery.of(context).size.width;
    double fontScaleFactor = MediaQuery.of(context).textScaleFactor;
    var commCardHeight = scrHeight * 0.125;

    return Container(
      height: commCardHeight,
      margin: EdgeInsets.all(scrWidth * 0.025),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            offset: const Offset(0, 1),
            color: appColors.black25,
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: commCardHeight * 0.2),
          Container(
            height: commCardHeight * 0.7,
            width: commCardHeight * 0.7,
            color: appColors.white,
            child: AvatarImage(url: contact.imageUri ?? ""),
          ),
          SizedBox(width: commCardHeight * 0.2),
          Container(
            width: scrWidth * 0.4,
            padding: EdgeInsets.symmetric(vertical: commCardHeight * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contact.name,
                  style: TextStyle(
                    color: appColors.black,
                    fontSize: 18 * fontScaleFactor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                isContacts
                    ? Container()
                    : Text(
                        '${contact.relation}',
                        style: TextStyle(
                          color: appColors.commRelationship,
                          fontSize: 16 * fontScaleFactor,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
              ],
            ),
          ),
          SizedBox(width: commCardHeight * 0),
          Row(
            children: [
              isContacts
                  ? Container(width: commCardHeight * 0.6)
                  : SizedBox(
                      height: commCardHeight * 0.7,
                      width: commCardHeight * 0.7,
                      child: Image.asset('assets/images/img_msg.png'),
                    ),
              InkWell(
                onTap: () => _openInDialer(contact.contact),
                child: Container(
                  height: commCardHeight * 0.7,
                  width: commCardHeight * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: appColors.event,
                  ),
                  padding: EdgeInsets.all(commCardHeight * 0.2),
                  child: Image.asset(
                    'assets/images/img_phone.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _openInDialer(String contact) async {
    Uri phone = Uri.parse('tel:$contact');
    await launchUrl(phone);
  }
}
