import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:samples/src/image_gallery/download/model/file_type.dart';
import 'package:samples/src/image_gallery/download/widget/download_widget.dart';

class DownLoadViewModel extends ChangeNotifier {
  bool isOverlayEnabled = false;

  bool isDownloading = true;
  bool isMinimised = false;

  double xPosition = 100;
  double yPosition = 80;

  double lastScrolledPosition = 0.0;

  List<DownLoadWidget> downloadedList = [];

  late ScrollController scrollController;

  updateIsDownloading(bool value) {
    isDownloading = value;
    notifyListeners();
  }
                        
  updateIsMinimising(bool value) {
    isMinimised = value;
    notifyListeners();
  }

  scrollListener() {
    scrollController =
        ScrollController(initialScrollOffset: lastScrolledPosition);
    scrollController.addListener(() {
      lastScrolledPosition = scrollController.position.pixels;
    });
  }

  updateXPosition(double x) {
    xPosition = x;
    notifyListeners();
  }

  updateYPosition(double y) {
    yPosition = y;
    notifyListeners();
  }

  enbaleOverlay(bool value) {
    isOverlayEnabled = value;
    notifyListeners();
  }

  insertDownloadWidget(DownLoadWidget widget) {
    downloadedList.add(widget);
    notifyListeners();
  }

  Future<bool> requestPermission() async {
    bool storagePermission = await Permission.storage.isGranted;
    bool mediaPermission = await Permission.accessMediaLocation.isGranted;
    bool manageExternal = await Permission.manageExternalStorage.isGranted;

    if (!storagePermission) {
      storagePermission = await Permission.storage.request().isGranted;
    }

    if (!mediaPermission) {
      mediaPermission =
          await Permission.accessMediaLocation.request().isGranted;
    }

    if (!manageExternal) {
      manageExternal =
          await Permission.manageExternalStorage.request().isGranted;
    }

    bool isPermissionGranted =
        storagePermission && mediaPermission && manageExternal;

    if (isPermissionGranted) {
      return true;
    } else {
      return false;
    }
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
