import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/view/users_list_screen.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    context.read<AuthViewModel>().updateUserOnlineStatus(true);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    listenAppState(state);
  }

  listenAppState(AppLifecycleState state) {
    final provider = context.read<AuthViewModel>();
    switch (state) {
      case AppLifecycleState.resumed:
        provider.updateUserOnlineStatus(true);
        break;
      case AppLifecycleState.inactive:
        provider.updateUserOnlineStatus(false);
        break;
      case AppLifecycleState.paused:
        provider.updateUserOnlineStatus(false);
        break;
      case AppLifecycleState.detached:
        provider.updateUserOnlineStatus(false);
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () async {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const UsersListScreen(),
                ),
              );
            },
            child: const Text("Fetch users list")),
      ),
    );
  }
}
