// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/data/model/message.dart';
import 'package:mira_care/resources/service/secure_storage.dart';
import 'package:mira_care/resources/service/storage_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class MessageWidget extends StatefulWidget {
  const MessageWidget({
    super.key,
    required this.message,
  });

  final UserMessage message;

  @override
  State<StatefulWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late UserMessage message;
  late Future<File?> _fileLoader;
  bool isVideo = false;
  String iconPreview = 'img';
  bool isCurrentUserId = false;

  @override
  void initState() {
    super.initState();
    message = widget.message;
    getIsCurrentUser();
  }

  getIsCurrentUser() async {
    isCurrentUserId = message.senderId == await secureStorage.get('uid');
    setState(() {});
  }

  Future<File?> getMultimediaPreview(String fileUri) async {
    File? file = await storageService.getFile(fileUri);
    String extension = p.extension(fileUri);
    String name = p.extension(fileUri, 2).split('.')[0];
    if (extension == '.mp4') {
      isVideo = true;
      Uint8List? image = await VideoThumbnail.thumbnailData(
        video: fileUri,
        imageFormat: ImageFormat.PNG,
        maxWidth: 120,
        maxHeight: 120,
      );

      if (image != null) {
        Uint8List imageInUnit8List = image;
        final tempDir = await getTemporaryDirectory();
        file = await File('${tempDir.path}/$name.png').create();
        file.writeAsBytesSync(imageInUnit8List);
      }
    } else if ([
      '.jpg',
      '.jpeg',
      '.WebP',
      '.png',
    ].contains(extension)) {
      setState(() {
        iconPreview = 'img';
      });
    } else if (['.doc', '.docx'].contains(extension)) {
      setState(() {
        iconPreview = 'document';
      });
    } else if (['.pdf'].contains(extension)) {
      setState(() {
        iconPreview = 'pdf';
      });
    } else {
      setState(() {
        iconPreview = 'music';
      });
    }
    return file;
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
    String date = '';
    bool isToday = DateFormat('dd MMM yyyy').format(message.dateTime) ==
        DateFormat('dd MMM yyyy').format(DateTime.now());

    bool isSameImg = message.imageUri ==
        "https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg";

    String avatarImage = isSameImg
        ? "https://www.tensionends.com/wp-content/uploads/2022/09/Beautiful-Girl-DP-Images-1.jpg"
        : '${message.imageUri}';

    try {
      date = DateFormat(isToday ? 'h:mm a' : 'MMMM d, h:mm a')
          .format(message.dateTime);
    } catch (e) {
      debugPrint('Null value in date');
    }

    double messageHeight =
        (scrHeight * message.factor) * message.contentHeightFactor;
    String? fileUri =
        message.isMultiMediaMsg ? message.multiMedia?.first : null;
    if (fileUri != null) {
      _fileLoader = getMultimediaPreview(fileUri);
    }
    double multiMediaHeight = fileUri != null ? scrHeight * 0.125 : 0;

    const Radius radius20 = Radius.circular(20);
    return Container(
      margin: EdgeInsets.symmetric(vertical: scrHeight * 0.005),
      width: scrHeight * 0.4,
      height: scrHeight * 0.0125 + messageHeight + multiMediaHeight,
      child: Stack(
        children: [
          Positioned(
            bottom: scrHeight * 0.01,
            left: isCurrentUserId ? null : 10,
            right: isCurrentUserId ? 10 : null,
            child: SizedBox(
              height: scrWidth * 0.1,
              width: scrWidth * 0.1,
              child: AvatarImage(
                  url: isCurrentUserId
                      ? "https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg"
                      : avatarImage),
            ),
          ),
          Positioned(
            bottom: scrHeight * -0.025,
            left: isCurrentUserId
                ? scrWidth * (isToday ? 0.63 : 0.5)
                : scrWidth * 0.15,
            right: isCurrentUserId ? scrWidth * 0.15 : scrWidth * 0.5,
            child: SizedBox(
              height: scrWidth * 0.1,
              width: scrWidth * 0.7,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12 * fontScaleFactor,
                  color: appColors.msgTextGray,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: scrHeight * 0.03,
            left: isCurrentUserId ? null : scrWidth * 0.15,
            right: isCurrentUserId ? scrWidth * 0.15 : null,
            child: message.isMultiMediaMsg
                ? Container(
                    decoration: BoxDecoration(
                      color: isCurrentUserId
                          ? appColors.currentUser
                          : appColors.messageGray,
                      borderRadius: BorderRadius.only(
                        topLeft: radius20,
                        topRight: radius20,
                        bottomRight: isCurrentUserId ? Radius.zero : radius20,
                        bottomLeft: isCurrentUserId ? radius20 : Radius.zero,
                      ),
                    ),
                    width: scrWidth * 0.65,
                    child: Stack(
                      children: [
                        Positioned(
                          top: scrHeight * 0.01,
                          left: scrWidth * 0.025,
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                width: scrWidth * 0.25,
                                height: scrHeight * 0.125,
                                child: FutureBuilder<File?>(
                                  future: _fileLoader,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<File?> snapshot) {
                                    if (snapshot.hasData &&
                                        iconPreview == 'img') {
                                      return Image.file(
                                        snapshot.data!,
                                        fit: BoxFit.contain,
                                      );
                                    } else {
                                      return Image.asset(
                                        'assets/images/${iconPreview}_preview.png',
                                        fit: BoxFit.contain,
                                      );
                                    }
                                  },
                                ),
                              ),
                              isVideo
                                  ? Positioned(
                                      top: scrHeight * 0.05,
                                      left: scrWidth * 0.1,
                                      width: scrHeight * 0.025,
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                          color: appColors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          size: 14 * fontScaleFactor,
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        Positioned(
                          top: scrHeight * 0.14,
                          child: Container(
                            decoration: BoxDecoration(
                              color: appColors.messageGray,
                              borderRadius: BorderRadius.only(
                                topLeft: radius20,
                                topRight: radius20,
                                bottomRight:
                                    isCurrentUserId ? Radius.zero : radius20,
                                bottomLeft:
                                    isCurrentUserId ? radius20 : Radius.zero,
                              ),
                            ),
                            width: scrWidth * 0.69,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                message.message,
                                style: TextStyle(
                                  fontSize: 14 * fontScaleFactor,
                                  color: appColors.black,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: isCurrentUserId
                          ? appColors.currentUser
                          : appColors.messageGray,
                      borderRadius: BorderRadius.only(
                        topLeft: radius20,
                        topRight: radius20,
                        bottomRight: isCurrentUserId ? Radius.zero : radius20,
                        bottomLeft: isCurrentUserId ? radius20 : Radius.zero,
                      ),
                    ),
                    width: scrWidth * 0.65,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          fontSize: 14 * fontScaleFactor,
                          color: appColors.black,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
