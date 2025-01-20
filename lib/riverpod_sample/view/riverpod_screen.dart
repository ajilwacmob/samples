import 'package:flutter/material.dart';
import 'package:samples/riverpod_sample/view/photos_screen.dart';
import 'package:samples/riverpod_sample/view/river_pod_sample_home_screen.dart';
import 'package:samples/riverpod_sample/view/statefull_consumer_screen.dart';
import 'package:samples/riverpod_sample/view/user_info_screen.dart';

class RiverpodScreen extends StatefulWidget {
  const RiverpodScreen({super.key});

  @override
  State<RiverpodScreen> createState() => _RiverpodScreenState();
}

class _RiverpodScreenState extends State<RiverpodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Riverpod Sample Home Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _navigateToConsumerWidget,
              child: const Text("Consumer Widget"),
            ),
            ElevatedButton(
              onPressed: _navigateToStateFullConsumerWidget,
              child: const Text("State Full Consumer Widget"),
            ),
            ElevatedButton(
              onPressed: _navigateToUserInfoScreen,
              child: const Text("User Info Screen"),
            ),
            ElevatedButton(
              onPressed: _navigateToPhotosScreen,
              child: const Text("Show Photos"),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToConsumerWidget() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RiverPodSampleHomeScreen();
    }));
  }

  void _navigateToStateFullConsumerWidget() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const StatefullConsumerScreen();
    }));
  }

  void _navigateToUserInfoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const UserInfoScreen();
    }));
  }

  void _navigateToPhotosScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const PhotosScreen();
    }));
  }
}
