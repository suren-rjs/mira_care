// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mira_care/constants/app_colors.dart';
import 'package:mira_care/resources/controller/notes_controller.dart';
import 'package:mira_care/resources/data/model/journal_note.dart';
import 'package:mira_care/resources/helper/file_selector.dart';
import 'package:mira_care/resources/service/storage_service.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class NewNoteInput extends StatefulWidget {
  const NewNoteInput({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NewNoteInputState();
}

class _NewNoteInputState extends State<NewNoteInput> {
  TextEditingController noteMessage = TextEditingController();
  List<File> localFiles = [];
  List<FileThumbArt> thumbArt = [];
  List<String> pathList = [];
  List<String> uploadedUrl = [];
  List<String> avatarUri = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPprK2UpcWM6d34sFN4LZARi59deYcjy2QuIVpydrTMg5HGpzDLfm5vngiqr0z4sz3B8U&usqp=CAU',
    'https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmInR4ljBH8rLmxngqj5KH5NIWJ6fdGtt8ow&usqp=CAU',
    'https://www.tensionends.com/wp-content/uploads/2022/09/Beautiful-Girl-DP-Images-1.jpg',
    'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'
  ];

  void selectFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'pdf',
        'doc',
        'docx',
        'jpeg',
        'WebP',
        'png',
        'mp4',
        'mp3'
      ],
    );

    if (result != null) {
      clearFiles();
      localFiles = result.paths.map((path) => File(path!)).toList();
      for (var file in localFiles) {
        String extension = p.extension(file.path);
        String name = p.extension(file.path, 2).split('.')[0];
        pathList.add(file.path);
        if (extension == '.mp4') {
          Uint8List? image = await VideoThumbnail.thumbnailData(
            video: file.path,
            imageFormat: ImageFormat.JPEG,
            maxWidth: 128,
            quality: 25,
          );

          if (image != null) {
            Uint8List imageInUnit8List = image;
            final tempDir = await getTemporaryDirectory();
            File generatedImage =
            await File('${tempDir.path}/$name.png').create();
            generatedImage.writeAsBytesSync(imageInUnit8List);
            thumbArt.add(FileThumbArt(generatedImage, 'video', name));
          }
        } else if (['.doc', '.docx'].contains(extension)) {
          thumbArt.add(FileThumbArt(file, 'document', name));
        } else if (['.pdf'].contains(extension)) {
          thumbArt.add(FileThumbArt(file, 'pdf', name));
        } else if (extension != '.mp3') {
          thumbArt.add(FileThumbArt(file, 'image', name));
        } else {
          thumbArt.add(FileThumbArt(file, 'music', name));
        }
      }
    }
    setState(() {});
  }

  void clearFiles() {
    localFiles.clear();
    thumbArt.clear();
    pathList.clear();
    uploadedUrl.clear();
  }

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
    InputBorder borderStyle = InputBorder.none;

    return GetBuilder<NotesController>(
      init: Get.put(NotesController()),
      builder: (controller) {
        return SizedBox(
          width: scrWidth,
          height: scrHeight * 0.2,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: scrHeight * 0.1,
                  width: scrWidth,
                  padding: EdgeInsets.symmetric(
                    vertical: scrWidth * 0.02,
                  ),
                  color: appColors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () => selectFiles(),
                        child: Container(
                          height: scrWidth * 0.125,
                          width: scrWidth * 0.125,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: appColors.msgPin,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Image.asset(
                            'assets/images/pin_icon.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        height: scrWidth * 0.125,
                        width: scrWidth * 0.5,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          border: Border.all(
                            width: 1,
                            color: appColors.msgInBorderGray,
                          ),
                        ),
                        child: TextField(
                          controller: noteMessage,
                          maxLines: 3,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: borderStyle,
                            hintText: 'Message',
                            hintStyle: TextStyle(
                              color: appColors.msgHintGray,
                              fontSize: 16 * fontScaleFactor,
                            ),
                            errorBorder: borderStyle,
                            focusedBorder: borderStyle,
                            disabledBorder: borderStyle,
                          ),
                        ),
                        // child: MessageInput(),
                      ),
                      InkWell(
                        onTap: () async {
                          if (localFiles.isNotEmpty) {
                            uploadedUrl.clear();
                            for (var file in localFiles) {
                              uploadedUrl.add(
                                await storageService.fileUpload(file.path),
                              );
                            }
                          }
                          await controller.newJournalNote(Note(
                            avatarImage:
                                avatarUri[Random().nextInt(avatarUri.length)],
                            dateTime: DateTime.now(),
                            content: noteMessage.text,
                            multiMedia: uploadedUrl,
                          ));
                          noteMessage.clear();
                          clearFiles();
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        child: Container(
                          height: scrWidth * 0.125,
                          width: scrWidth * 0.2,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: appColors.msgPin,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Send',
                              style: TextStyle(
                                color: appColors.black,
                                fontSize: 18 * fontScaleFactor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              thumbArt.isNotEmpty
                  ? Positioned(
                      top: scrHeight * 0.01,
                      bottom: scrHeight * 0.1,
                      child: Container(
                        height: scrHeight * 0.2,
                        width: scrWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: scrWidth * 0.02,
                        ),
                        color: appColors.attachment,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: thumbArt.length,
                          itemBuilder: (context, index) {
                            FileThumbArt thumbArtFile = thumbArt[index];
                            String previewImage =
                                'assets/images/${thumbArtFile.extension}_preview.png';
                            String name = thumbArtFile.name;
                            return Stack(
                              children: [
                                Positioned(
                                  child: Container(
                                    height: scrHeight * 0.07,
                                    width: scrHeight * 0.07,
                                    decoration: BoxDecoration(
                                      color: appColors.transparent,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    margin: EdgeInsets.all(
                                      scrHeight * 0.01,
                                    ),
                                    child: Semantics(
                                      label: name,
                                      container: true,
                                      child: ['image', 'video']
                                              .contains(thumbArtFile.extension)
                                          ? Image.file(
                                              thumbArtFile.file,
                                              fit: BoxFit.fitWidth,
                                            )
                                          : Image.asset(
                                              previewImage,
                                              fit: BoxFit.contain,
                                            ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 1,
                                  top: 1,
                                  height: scrHeight * 0.02,
                                  width: scrHeight * 0.02,
                                  child: InkWell(
                                    onTap: () {
                                      localFiles.removeAt(index);
                                      thumbArt.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: appColors.white,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(35),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        size: 14 * fontScaleFactor,
                                      ),
                                    ),
                                  ),
                                ),
                                ['video'].contains(thumbArtFile.extension)
                                    ? Positioned(
                                        right: scrHeight * 0.0325,
                                        top: scrHeight * 0.0325,
                                        height: scrHeight * 0.025,
                                        width: scrHeight * 0.025,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: appColors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(35),
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
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
