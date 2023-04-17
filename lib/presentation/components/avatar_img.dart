import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: Image.network(
        url,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/img_error_contact.png',
            fit: BoxFit.contain,
          );
        },
      ).image,
      backgroundColor: appColors.weekDayBackground,
    );
  }
}
