import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/chat_module/utils/firebase_keys.dart';
import 'package:samples/chat_module/view/chat_home_screen.dart';
import 'package:samples/chat_module/view/enter_details_screen.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';

class LoginAndSignInScreen extends StatefulWidget {
  const LoginAndSignInScreen({super.key});

  @override
  State<LoginAndSignInScreen> createState() => _LoginAndSignInScreenState();
}

class _LoginAndSignInScreenState extends State<LoginAndSignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(builder: (_, provider, __) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                provider.isLogIn
                    ? "Login with your registered email and password"
                    : "Register new account with email and password",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              30.verticalSpace,
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              16.verticalSpace,
              ElevatedButton(
                onPressed: () async {
                  if (_emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty) {
                    if (provider.isLogIn) {
                      bool isSuccess = await provider.login(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (isSuccess) {
                        final token =
                            await FirebaseMessaging.instance.getToken();
                        User? user = FirebaseAuth.instance.currentUser;
                        final loginTime = DateTime.now().toIso8601String();
                        Map<String, dynamic> params = {
                          FirebaseKeys.token: token,
                          FirebaseKeys.lastLogin: loginTime,
                        };
                        provider.updateData(
                            params: params, userId: user?.uid ?? "");
                        bool? isDataFilled =
                            await provider.checkUserIsFilledData();

                        if (mounted &&
                            isDataFilled != null &&
                            isDataFilled != false) {
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
                      }
                    } else {
                      bool isSuccess = await provider.signIn(
                          email: _emailController.text,
                          password: _passwordController.text);
                      if (isSuccess) {
                        if (mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const EnterDetailsScreen(),
                              ),
                              (route) => false);
                        }
                      }
                    }
                  }
                },
                child: Text(provider.isLogIn ? 'Login' : "Sign In"),
              ),

              const SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () {
                    if (provider.isLogIn) {
                      provider.updateLoginStatus(false);
                    } else {
                      provider.updateLoginStatus(true);
                    }
                  },
                  child: !provider.isLogIn
                      ? const Text("Already have an account? Login")
                      : const Text("Dont have an account? SignIn"))
              // if (_errorMessage.isNotEmpty)
              //   Text(
              //     _errorMessage,
              //     style: TextStyle(color: Colors.red),
              //   ),
            ],
          );
        }),
      ),
    );
  }
}
