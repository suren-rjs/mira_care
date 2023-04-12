import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

// ignore: library_private_types_in_public_api
_StorageService storageService = _StorageService.instance;

class _StorageService {
  _StorageService._();

  static final _StorageService instance = _StorageService._();

  Future<String> fileUpload(filePath) async {
    String extension = p.extension(filePath);
    final file = File(filePath);
    String name = const Uuid().v4();

    String contentType = lookupMimeType(file.path) ?? '';
    final metadata = SettableMetadata(contentType: contentType);

    final storageRef = FirebaseStorage.instance.ref();

    final uploadTask =
        storageRef.child("files/$name$extension").putFile(file, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          debugPrint("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          debugPrint("Upload is paused.");
          break;
        case TaskState.canceled:
          debugPrint("Upload was canceled");
          break;
        case TaskState.error:
          break;
        case TaskState.success:
          break;
      }
    });

    return name;
  }

  Future<File> getFile(name) async {
    String fileUrl = await FirebaseStorage.instance
        .ref()
        .child('files/$name')
        .getDownloadURL();

    var response = await http.get(Uri.parse(fileUrl));

    File file = File('/files/');
    file.writeAsBytesSync(response.bodyBytes);
    debugPrint('downloaded');
    return file;
  }
}
