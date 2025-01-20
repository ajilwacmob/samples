import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatefullConsumerScreen extends ConsumerStatefulWidget {
  const StatefullConsumerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StatefullConsumerScreenState();
}

class _StatefullConsumerScreenState
    extends ConsumerState<StatefullConsumerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
