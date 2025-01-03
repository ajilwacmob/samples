import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/view/chat_home_screen.dart';
import 'package:samples/chat_module/view/chat_login_and_sigin_screen.dart';
import 'package:samples/chat_module/view/enter_details_screen.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();
    super.initState();
  }

  checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    bool? isDataFilled =
        await context.read<AuthViewModel>().checkUserIsFilledData();
    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        if (mounted && isDataFilled != null && isDataFilled != false) {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (_) => const ChatHomeScreen(),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(
                builder: (_) => const EnterDetailsScreen(),
              ),
              (route) => false);
        }
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (_) => const LoginAndSignInScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Text(
          "Free Chat",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
