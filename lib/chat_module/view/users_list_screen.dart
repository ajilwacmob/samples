import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/model/user_model.dart';
import 'package:samples/chat_module/view/chat_screen.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';
import 'package:samples/utils/common_functions.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  void initState() {
    afterInit(loadData);
    super.initState();
  }

  loadData() {
    context.read<AuthViewModel>().fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(
        builder: (_, provider, __) {
          if (provider.isUsersFetching) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: provider.users.length,
              itemBuilder: (_, index) {
                Map<String, dynamic> data =
                    provider.users[index].data()! as Map<String, dynamic>;
                var user = UserModel.fromJson(data);
                String? fullName = "${user.firstName} ${user.lastName}";
                String? imgUrl = user.profileUrl;
                String? bio = user.bio;
                return ListTile(
                  title: Text(fullName ),
                  subtitle: Text(
                    bio ?? "",
                    maxLines: 1,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => ChatScreen(userModel: user),
                      ),
                    );
                  },
                  leading: imgUrl != null
                      ? CircleAvatar(
                          radius: 25, backgroundImage: NetworkImage(imgUrl))
                      : null,
                );
              });
        },
      ),
    );
  }
}
