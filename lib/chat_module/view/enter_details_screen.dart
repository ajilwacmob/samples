import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/chat_module/utils/firebase_keys.dart';
import 'package:samples/chat_module/view/chat_home_screen.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({super.key});

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final bioController = TextEditingController();

  late AuthViewModel authViewModel;

  @override
  void initState() {
    authViewModel = context.read<AuthViewModel>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Details"),
      ),
      body: Selector<AuthViewModel, bool>(
          selector: (_, selector) => selector.isInsertingData,
          builder: (_, isInsertingData, __) {
            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    20.verticalSpace,
                    const Text(
                      "Hi there,\nPlease fill your basic details here",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    30.verticalSpace,
                    TextField(
                      controller: firstNameController,
                      decoration:
                          const InputDecoration(labelText: 'First Name'),
                    ),
                    10.verticalSpace,
                    TextField(
                      controller: lastNameController,
                      decoration: const InputDecoration(labelText: 'Last Name'),
                    ),
                    10.verticalSpace,
                    TextField(
                      controller: bioController,
                      minLines: 1,
                      maxLines: 5,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(150),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Bio',
                      ),
                    ),
                    30.verticalSpace,
                    SizedBox(
                      width: 120,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (firstNameController.text.trim().isEmpty ||
                              lastNameController.text.trim().isEmpty ||
                              bioController.text.trim().isEmpty) {
                            return;
                          }
                          if (!isInsertingData) {
                            FocusScope.of(context).unfocus();
                            final token =
                                await FirebaseMessaging.instance.getToken();
                            User? user = FirebaseAuth.instance.currentUser;
                            final email = user?.email;
                            final uid = user?.uid;
                            final loginTime = DateTime.now().toIso8601String();
                            Map<String, dynamic> params = {
                              FirebaseKeys.firstName: firstNameController.text,
                              FirebaseKeys.lastName: lastNameController.text,
                              FirebaseKeys.bio: bioController.text,
                              FirebaseKeys.profileUrl: "",
                              FirebaseKeys.email: email,
                              FirebaseKeys.token: token,
                              FirebaseKeys.uid: uid,
                              FirebaseKeys.lastLogin: loginTime,
                              FirebaseKeys.isUserDataFilled: true,
                              FirebaseKeys.isOnline: false,
                              FirebaseKeys.lastSeen: loginTime,
                              FirebaseKeys.blockedRecipients: [],
                              FirebaseKeys.messagedRecipients: []
                            };
                            bool isSuccess = await authViewModel.insertUserData(
                              params: params,
                              userId: params['uid'],
                            );
                            if (isSuccess && mounted) {
                              Navigator.pushAndRemoveUntil(
                                  // ignore: use_build_context_synchronously
                                  context,
                                  CupertinoPageRoute(
                                    builder: (_) => const ChatHomeScreen(),
                                  ),
                                  (route) => false);
                            }
                          }
                          //  print(jsonData?['uid']);
                        },
                        child: !isInsertingData
                            ? const Text("Submit")
                            : const Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
