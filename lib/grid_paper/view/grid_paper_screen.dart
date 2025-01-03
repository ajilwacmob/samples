import 'package:flutter/material.dart';

class GridPaperScreen extends StatefulWidget {
  const GridPaperScreen({super.key});

  @override
  State<GridPaperScreen> createState() => _GridPaperScreenState();
}

class _GridPaperScreenState extends State<GridPaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grid Paper'),
      ),
      body: GridPaper(
        color: const Color.fromARGB(255, 255, 255, 255),
        divisions: 1,
        subdivisions: 1,
        interval: 100,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
