import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DownlaodFileScreen extends StatefulWidget {
  const DownlaodFileScreen({super.key});

  @override
  State<DownlaodFileScreen> createState() => _DownlaodFileScreenState();
}

class _DownlaodFileScreenState extends State<DownlaodFileScreen> {
  download({
    Function(
      double percentage,
      int totalBytes,
      int downloadedBytes,
    )?
        onProgress,
  }) async {
    double actualPercentage = 0;
    int downloadBytes = 0;
    //String uploadMsg = '';

    List<List<int>> chunks = [];

    var pdfUrl =
        "https://formation2-test.jesusyouth.org/api/v1/course-materials/14/download";

    // var videoUrl =
    //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

    var url = Uri.parse(pdfUrl);

    var request = http.Request("GET", url);
    Iterable<MapEntry<String, String>> headers = [
      const MapEntry(
        HttpHeaders.acceptHeader,
        "application/json",
      ),
      const MapEntry(
        HttpHeaders.contentTypeHeader,
        "application/json",
      ),
      const MapEntry(
        HttpHeaders.authorizationHeader,
        "Bearer qphZlTZhraHibTLH7cQUKaBNPr6RyV4o",
      ),
    ];
    request.headers.addEntries(headers);
    Future<http.StreamedResponse> send = request.send();

    send.asStream().listen((http.StreamedResponse r) {
      r.stream.listen((List<int> chunk) {
        if (r.contentLength != null) {
          chunks.add(chunk);
          downloadBytes += chunk.length;
          actualPercentage = downloadBytes / (r.contentLength!.toInt()) * 100;

          if (onProgress != null) {
            onProgress(
                actualPercentage, downloadBytes, r.contentLength!.toInt());
          }
        }
      }, onDone: () async {
        print("Completed");
      }, onError: (e) {
        print("Error ${e.toString()}");
      });
    });

    // http.Response responseFromStreamed =
    //     await http.Response.fromStream(await send);
    // print(responseFromStreamed.statusCode);
    send.then((value) async {
      Future<Uint8List> bytes = value.stream.toBytes();
      print(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              download(
                onProgress: (percentage, totalBytes, downloadedBytes) {
                  print(percentage);
                },
              );
            },
            child: const Text("Download File")),
      ),
    );
  }
}
