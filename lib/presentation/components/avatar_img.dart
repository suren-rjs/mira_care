import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mira_care/constants/app_colors.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({
    super.key,
    this.url,
    this.memoryImage,
  });

  final String? url;
  final Uint8List? memoryImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: memoryImage != null && (memoryImage?.isNotEmpty ?? false)
          ? Image.memory(memoryImage!).image
          : !(['', 'null', null].contains(url))
              ? Image.network(
                  url!,
                ).image
              : Image.asset(
                  'assets/images/img_error_contact.png',
                  fit: BoxFit.fitWidth,
                ).image,
      backgroundColor: appColors.weekDayBackground,
    );
  }
}
