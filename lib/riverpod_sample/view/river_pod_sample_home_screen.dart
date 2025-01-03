import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) => 0);

class RiverPodSampleHomeScreen extends ConsumerWidget {
  const RiverPodSampleHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Counter',
        style: TextStyle(color: Colors.white),
      )),
      body: Center(
          child: Text(
        'Counter: $counter',
        style: const TextStyle(color: Colors.white),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
