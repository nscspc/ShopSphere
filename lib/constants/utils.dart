import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<List<File>> pickImages() async {
  // dart.io is required not dart.html.
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
      // final fileBytes = files.files.first.bytes;
      // final fileName = files.files.first.name;
      // images.add(fileBytes as File);
//        InputStream input = new ByteArrayInputStream(bytes);
// OutputStream output = new FileOutputStream(fileName);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<List<PlatformFile>> pickImagesInBytes() async {
  // dart.io is required not dart.html.
  List<PlatformFile> images = [];
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      for (int i = 0; i < result.files.length; i++) {
        images.add(result.files[i]);
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
