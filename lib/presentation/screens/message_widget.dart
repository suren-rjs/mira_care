// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/presentation/components/avatar_img.dart';
import 'package:mira_care/resources/data/model/journal_note.dart';
import 'package:mira_care/resources/service/storage_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ReceivedMessage extends StatefulWidget {
  const ReceivedMessage({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<StatefulWidget> createState() => _ReceivedMessageState();
}

class _ReceivedMessageState extends State<ReceivedMessage> {
  late Note note;
  late Future<File?> _fileLoader;
  bool isVideo = false;
  String iconPreview = 'img';

  @override
  void initState() {
    super.initState();
    note = widget.note;
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
      iconPreview = 'img';
    } else if (['.doc', '.docx'].contains(extension)) {
      iconPreview = 'document';
    } else if (['.pdf'].contains(extension)) {
      iconPreview = 'pdf';
    } else {
      iconPreview = 'music';
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

    try {
      date = DateFormat('MMMM d, h:mm a').format(note.dateTime!);
    } catch (e) {
      debugPrint('Null value in date');
    }

    double messageHeight = (scrHeight * note.factor) * note.contentHeightFactor;
    String? fileUri = note.isMultimediaMsg ? note.multiMedia?.first : null;
    if (fileUri != null) {
      _fileLoader = getMultimediaPreview(fileUri);
    }
    double multiMediaHeight = fileUri != null ? scrHeight * 0.125 : 0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: scrHeight * 0.005),
      width: scrHeight * 0.4,
      height: scrHeight * 0.0125 + messageHeight + multiMediaHeight,
      child: Stack(
        children: [
          Positioned(
            bottom: scrHeight * 0.01,
            child: SizedBox(
              height: scrWidth * 0.1,
              width: scrWidth * 0.1,
              child: AvatarImage(url: note.avatarImage ?? ''),
            ),
          ),
          Positioned(
            bottom: scrHeight * -0.025,
            left: scrWidth * 0.15,
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
            left: scrWidth * 0.15,
            child: note.isMultimediaMsg
                ? Container(
                    decoration: BoxDecoration(
                      color: appColors.messageGray,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: scrWidth * 0.69,
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
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            width: scrWidth * 0.69,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                note.content ?? '',
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
                      color: appColors.messageGray,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    width: scrWidth * 0.69,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        note.content ?? '',
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
