import 'package:flutter/material.dart';
import 'package:samples/custom_bottom_nav/custom_bottom_navigation_painter.dart';
import 'package:samples/music_module/view/widget/music_bottom_bar.dart';
import 'package:samples/music_module/view/widget/music_bottom_nab_bar.dart';

class MusicMainHomeScreen extends StatefulWidget {
  const MusicMainHomeScreen({super.key});

  @override
  State<MusicMainHomeScreen> createState() => _MusicMainHomeScreenState();
}

class _MusicMainHomeScreenState extends State<MusicMainHomeScreen> {
  final List<Widget> screens = [
    const Screen(
      title: "Screen One",
    ),
    const Screen(
      title: "Screen Two",
    ),
    const Screen(
      title: "Screen Three",
    ),
    const Screen(
      title: "Screen Four",
    ),
    const Screen(
      title: "Screen Five",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: 2,
            children: screens,
          ),
          const MusicBottomBar(),
        ],
      ),
      bottomNavigationBar: MusicBottomNavBar(),
    );
  }
}
