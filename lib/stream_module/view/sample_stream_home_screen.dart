import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:samples/stream_module/service/stream_service.dart';

class SampleStreamHomeScreen extends StatefulWidget {
  const SampleStreamHomeScreen({super.key});

  @override
  State<SampleStreamHomeScreen> createState() => _SampleStreamHomeScreenState();
}

class _SampleStreamHomeScreenState extends State<SampleStreamHomeScreen> {
  List<Map<String, dynamic>> data = [];
  final ScrollController controller = ScrollController();

  VoidCallback? voidCallback;

  Timer? time;

  @override
  void initState() {
    _listen();
    super.initState();
  }

  _scrollUp() async {
    // double maxScrollPos = controller.position.maxScrollExtent;
    // double screenHeight = context.size?.height ?? 0;
    //if (maxScrollPos > screenHeight) {
    controller.animateTo(controller.position.maxScrollExtent + 70,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
    //}
  }

  _listen() {
    // Update UI
    StreamService.instance.listen((event) {
      setState(() {
        data.add(event as Map<String, dynamic>);
      });
      _scrollUp();
    });

    // Send Notification
    StreamService.instance.listen((event) {});

    // Save
    StreamService.instance.listen((event) {});
  }

  @override
  void dispose() {
    StreamService.instance.closeStream();
    time?.cancel();
    super.dispose();
  }

  _onPressed() {
    time ??= Timer.periodic(const Duration(milliseconds: 500), (timer) {
      StreamService.instance.addData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text(
          "Multiple Stream Listeners",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.separated(
        itemCount: data.length,
        controller: controller,
        separatorBuilder: (context, index) => const Divider(
          indent: 12,
          endIndent: 12,
          color: Colors.grey,
          thickness: 0.7,
          height: 0,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            title: Text(
              data[index]['date'],
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text(
              data[index]['date'],
              style: const TextStyle(color: Colors.black),
            ),
            trailing: const Icon(Icons.arrow_right_rounded),
          );
        },
      ),
      floatingActionButton:
          time != null ? null : FloatingActionButton(onPressed: _onPressed),
    );
  }
}
