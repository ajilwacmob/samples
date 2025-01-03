import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:samples/src/image_gallery/download/model/file_type.dart';

class DownloadHelperViewModel extends ChangeNotifier {
  String savedFilePath = '';
  String filePath = '';
  double circularProgress = 6.28318530718;

  String fileExtension = '';
  double totalBites = 0.0;
  double downloadedBytes = 0.0;

  bool isFileDownloaded = false;

  Future<void> downloadFile(String url, String fileName) async {
    bool isFileExist = await checkFileExists(url, fileName, false);
    if (isFileExist) {
      return;
    }
    try {
      final dio = Dio();
     await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
        onReceiveProgress: (received, total) {
          double progress = (received / total * 100).abs();
          downloadedBytes = received.toDouble();
          totalBites = total.toDouble();
          print('Downloaded: ${progress.toStringAsFixed(2)}%');
          circularProgress = progress / 15.915494309188485;
          notifyListeners();
        },
      );
      var removeDot = url.split(".");
      final fileExtension = removeDot.last;
      var fType = getFileType(fileExtension: fileExtension);
      final file = await _createFile(
          fileName: fileName, fileExtension: fileExtension, fileType: fType);
      // File fileRename =
      //     await file.writeAsBytes(response.data, mode: FileMode.write);
      filePath = file.path;
      isFileDownloaded = true;
      notifyListeners();
      print(filePath);
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  Future<File> _createFile(
      {required String fileName,
      required String fileExtension,
      required String fileType}) async {
    final directory = await getExternalStorageDirectory();
    const dot = ".";
    final fileEndName = "${fileName}_$fileType$dot$fileExtension";
    final path = "${directory!.path}/sample/$fileType/$fileEndName";
    return File(path).create(recursive: true);
  }

  Future<bool> checkFileExists(
      String url, String fileName, bool isNeedToOpen) async {
    var removeDot = url.split(".");
    final fileExtension = removeDot.last;
    final directory = await getExternalStorageDirectory();
    var fType = getFileType(fileExtension: fileExtension);
    const dot = ".";
    final fileEndName = "${fileName}_$fType$dot$fileExtension";
    String fullFilePath = "${directory!.path}/sample/$fType/$fileEndName";
    File file = File(fullFilePath);
    if (await file.exists()) {
      if (isNeedToOpen) {
        OpenFileSafePlus.open(fullFilePath);
      }
      return true;
    } else {
      return false;
    }
  }

  String getFileType({required String fileExtension}) {
    int index = fileType
        .indexWhere((element) => element.entries.first.key == fileExtension);
    if (index != -1) {
      return fileType[index].entries.first.value;
    } else {
      return '';
    }
  }
}
