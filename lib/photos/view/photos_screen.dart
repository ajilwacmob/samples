import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:samples/photos/model/photos_model.dart';
import 'package:http/http.dart' as http;

Future<List<PhotosModel>> jsonParse(String jsonBody) async {
  var data = jsonDecode(jsonBody) as List<dynamic>;
  return data.map<PhotosModel>((e) => PhotosModel.fomJson(e)).toList();
}

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    return compute(jsonParse, response.body.toString());
  }

  ValueNotifier<List<PhotosModel>> photosNotifier = ValueNotifier([]);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    getPhotos().then((value) {
      log(value.length.toString());
      photosNotifier.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scroll to Top Example')),
      floatingActionButton: FloatingActionButton(onPressed: () {
        /*   photosNotifier.value = [];
        getData(); */
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: const Duration(seconds: 5),
              curve: Curves.easeInExpo);
        } else {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 5),
              curve: Curves.easeInExpo);
        }
      }),
      body: ValueListenableBuilder(
          valueListenable: photosNotifier,
          builder: (context, data, child) {
            if (data.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Scrollbar(
              controller: _scrollController,
              interactive: true,
              trackVisibility: true,
              child: GridView.builder(
                controller: _scrollController,
                // itemCount: itemList.length,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 150 / 200,
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2),

                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          data[index].url ?? "",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      8.vg,
                      Text(
                        data[index].title ?? "",
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.black,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                        ),
                      ),
                      5.vg,
                    ],
                  );
                },
              ),
            );
          }),
    );
  }
}

extension SizedBoxExtensions on int {
  SizedBox get hg => SizedBox(width: toDouble());
  SizedBox get vg => SizedBox(height: toDouble());
}
