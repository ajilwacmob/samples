import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samples/riverpod_sample/notifiers/app_data_notifier.dart';
import 'package:samples/riverpod_sample/states/app_data_state.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final appDataProvider =
      NotifierProvider<AppDataNotifier, AppDataState>(AppDataNotifier.new);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  InputDecoration buildInputDecoration(
      {required String labelText, required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.5),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
      ),
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
      ),
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appDataNotifier = ref.read(appDataProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "User Info Screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            20.verticalSpace,
            TextFormField(
              controller: _nameController,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              cursorColor: Colors.black,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: buildInputDecoration(
                hintText: "Enter your name",
                labelText: "User Name",
              ),
              onChanged: (value) {
                final text = value.trim();
                appDataNotifier.validateName(text);
              },
            ),
            Consumer(builder: (context, watch, child) {
              final appData = ref.watch(appDataProvider);
              final userNameError = appData.userNameError ?? "";

              return userNameError.isNotEmpty
                  ? Text(
                      userNameError,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    )
                  : const SizedBox.shrink();
            }),
            20.verticalSpace,
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.black),
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              decoration: buildInputDecoration(
                hintText: "Enter your email id",
                labelText: "Email-Id",
              ),
              onChanged: (value) {
                final text = value.trim();
                appDataNotifier.validateEmail(text);
              },
            ),
            Consumer(builder: (context, watch, child) {
              final appData = ref.watch(appDataProvider);
              final emailError = appData.emailError ?? "";

              return emailError.isNotEmpty
                  ? Text(
                      emailError,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    )
                  : const SizedBox.shrink();
            }),
            30.verticalSpace,
            Center(
              child: SizedBox(
                width: size.width * .5,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    ),
                    onPressed: () {
                      final userName = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      if (userName.isEmpty || email.isEmpty) {
                        appDataNotifier.validateName(userName);
                        appDataNotifier.validateEmail(email);
                        return;
                      } else {
                        appDataNotifier.addUserData(
                          UserData(name: userName, email: email),
                        );
                        _emailController.clear();
                        _nameController.clear();
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Add Data",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            const Divider(),
            Expanded(
              child: Consumer(
                builder: (_, ref, __) {
                  final appData = ref.watch(appDataProvider);

                  List<UserData> users = appData.users ?? [];

                  return users.isNotEmpty
                      ? ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "Name: ${users[index].name}",
                                style: const TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(
                                "Email: ${users[index].email}",
                                style: const TextStyle(color: Colors.black),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  appDataNotifier.removeUserData(users[index]);
                                },
                              ),
                            );
                          },
                        )
                      : SizedBox(
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "No data found",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              5.verticalSpace,
                              const Icon(
                                Icons.no_sim_outlined,
                                color: Colors.grey,
                                size: 50,
                              )
                            ],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
