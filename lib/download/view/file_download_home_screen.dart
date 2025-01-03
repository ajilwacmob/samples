import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileDownloadHomeScreen extends StatefulWidget {
  const FileDownloadHomeScreen({super.key});

  @override
  State<FileDownloadHomeScreen> createState() => _FileDownloadHomeScreenState();
}

class _FileDownloadHomeScreenState extends State<FileDownloadHomeScreen> {
  final Dio _dio = Dio();
  String? _filePath;
  CancelToken? _cancelToken;
  int _downloadedBytes = 0;
  int _totalBytes = 0;
  bool _isDownloading = false;
  String _status = "Idle";

  String videoUrl =
      "https://cdn.pixabay.com/video/2023/10/19/185726-876210695_large.mp4";

  Future<String> _getFilePath(String filename) async {
    final directory = await getExternalStorageDirectory();
    return "${directory!.path}/$filename";
  }

  Future<void> _startDownload(String url, String filename) async {
    _cancelToken = CancelToken();
    _filePath = await _getFilePath(filename);

    setState(() {
      _status = "Downloading...";
      _isDownloading = true;
    });

    try {
      // Open file for appending data
      final file = File(_filePath!);
      if (!await file.exists()) {
        await file.create();
      }
      _downloadedBytes = await file.length();

      // Set up download range
      // Options options = Options(
      //   headers: {"Range": "bytes=$_downloadedBytes-"},
      // );

      await _dio.download(
        url,
        _filePath!,
        //options: options,
        cancelToken: _cancelToken,
        onReceiveProgress: (received, total) {
          setState(() {
            _downloadedBytes = _downloadedBytes + received;
            _totalBytes = total + _downloadedBytes;
            _status =
                "Downloading: ${(_downloadedBytes / _totalBytes * 100).toStringAsFixed(0)}%";
          });
        },
      );

      setState(() {
        _status = "Download Complete";
        _isDownloading = false;
      });
    } catch (e) {
      if (CancelToken.isCancel(e as DioException)) {
        setState(() {
          _status = "Download Canceled";
        });
      } else {
        setState(() {
          _status = "Download Failed: $e";
        });
      }
    }
  }

  void _pauseDownload() {
    if (_cancelToken != null && _isDownloading) {
      _cancelToken!.cancel();
      setState(() {
        _status = "Paused";
        _isDownloading = false;
      });
    }
  }

  Future<void> _resumeDownload(String url, String filename) async {
    if (!_isDownloading) {
      await _startDownload(url, filename);
    }
  }

  void _cancelDownload() {
    _pauseDownload();
    if (_filePath != null) {
      File(_filePath!).deleteSync();
    }
    setState(() {
      _status = "Canceled and File Deleted";
      _filePath = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("File Download Home Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _status,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _startDownload(videoUrl, "largevideo.mp4");
              },
              child: const Text("Start Download"),
            ),
            ElevatedButton(
              onPressed: _pauseDownload,
              child: const Text("Pause Download"),
            ),
            ElevatedButton(
              onPressed: () {
                _resumeDownload(videoUrl, "largevideo.mp4");
              },
              child: const Text("Resume Download"),
            ),
            ElevatedButton(
              onPressed: _cancelDownload,
              child: const Text("Cancel Download"),
            ),
          ],
        ),
      ),
    );
  }
}
