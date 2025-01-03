import 'package:flutter/material.dart';

class UniLinkDetailsScreen extends StatefulWidget {
  const UniLinkDetailsScreen({super.key});

  @override
  State<UniLinkDetailsScreen> createState() => _UniLinkDetailsScreenState();
}

class _UniLinkDetailsScreenState extends State<UniLinkDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UniLink Details Screen"),
      ),
    );
  }
}
