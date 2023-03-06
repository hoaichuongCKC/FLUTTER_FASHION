import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CameraInfo {
  final ImagePicker _imagePicker;

  CameraInfo(ImagePicker imagePicker) : _imagePicker = imagePicker;

  Future<void> getLostData() async {
    final LostDataResponse response = await _imagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      // for (final XFile file in response.files!) {}
    } else {}
  }

  Future openGallery() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    return image;
  }

  Future openCamera() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    return image;
  }

  Future<File?> compressAndGetFile(File file, String targetPath,
      {Size size = const Size(1920, 1080)}) async {
    final filePath = file.absolute.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));

    final splitted = filePath.substring(0, (lastIndex));

    final outPath =
        "${splitted}_${targetPath}_out${filePath.substring(lastIndex)}";

    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
    );

    return result;
  }
}
