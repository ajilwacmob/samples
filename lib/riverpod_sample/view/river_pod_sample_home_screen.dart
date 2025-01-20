import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// **1. Provider - Immutable Data**
final appConfigProvider = Provider<String>((ref) => "Riverpod Example App");

// **2. StateProvider - Mutable State**
final counterProvider = StateProvider<int>((ref) => 0);

// **3. FutureProvider - Async Data**
final asyncDataProvider = FutureProvider<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return "Data Loaded Successfully";
});

// **4. StreamProvider - Real-Time Data**
final streamProvider = StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 1), (count) => count);
});

// **5. StateNotifierProvider - Complex State**
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state--;
}

final counterNotifierProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier());

// **6. ChangeNotifierProvider - ChangeNotifier**
class ThemeNotifier extends ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}

final themeProvider =
    ChangeNotifierProvider<ThemeNotifier>((ref) => ThemeNotifier());

// **7. NotifierProvider - Modern State Management**
class GreetingNotifier extends Notifier<String> {
  @override
  String build() => "Hello, Riverpod!";

  void updateGreeting(String newGreeting) => state = newGreeting;
}

final greetingProvider =
    NotifierProvider<GreetingNotifier, String>(GreetingNotifier.new);

// **8. Family Modifier**
final userProvider = FutureProvider.family<String, int>((ref, userId) async {
  await Future.delayed(const Duration(seconds: 1));
  return "User #$userId";
});

// **9. AutoDispose Modifier**
final temporaryProvider = FutureProvider.autoDispose<String>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return "Temporary Data Loaded";
});

class RiverPodSampleHomeScreen extends ConsumerWidget {
  RiverPodSampleHomeScreen({super.key});

  final counterProvider = StateProvider<int>((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(ref.watch(appConfigProvider)), // From Provider
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **2. StateProvider**

              Consumer(
                builder: (context, ref, child) {
                  final count = ref.watch(counterProvider);
                  return Row(
                    children: [
                      Text('Counter: $count'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () =>
                            ref.read(counterProvider.notifier).state++,
                      ),
                    ],
                  );
                },
              ),

              const Divider(),

              // **3. FutureProvider**
              ref.watch(asyncDataProvider).when(
                    data: (value) => Text(value),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, s) => Text("Error: $e"),
                  ),

              const Divider(),

              // **4. StreamProvider**
              Consumer(
                builder: (context, ref, child) {
                  return ref.watch(streamProvider).when(
                        data: (value) => Text("Stream Value: $value"),
                        loading: () => const CircularProgressIndicator(),
                        error: (e, s) => Text("Error: $e"),
                      );
                },
              ),

              const Divider(),

              // **5. StateNotifierProvider**
              Row(
                children: [
                  Text(
                      'Notifier Counter: ${ref.watch(counterNotifierProvider)}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () =>
                        ref.read(counterNotifierProvider.notifier).increment(),
                  ),
                ],
              ),

              const Divider(),

              // **6. ChangeNotifierProvider**
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: isDarkMode,
                onChanged: (value) => ref.read(themeProvider).toggleTheme(),
              ),

              const Divider(),

              // **7. NotifierProvider**
              Text("Greeting: ${ref.watch(greetingProvider)}"),
              TextField(
                onChanged: (value) =>
                    ref.read(greetingProvider.notifier).updateGreeting(value),
                decoration: const InputDecoration(labelText: 'Update Greeting'),
              ),

              const Divider(),

              // **8. Family Modifier**
              ref.watch(userProvider(10)).when(
                    data: (value) => Text(value),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, s) => Text("Error: $e"),
                  ),

              const Divider(),

              // **9. AutoDispose**
              ref.watch(temporaryProvider).when(
                    data: (value) => Text(value),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, s) => Text("Error: $e"),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
