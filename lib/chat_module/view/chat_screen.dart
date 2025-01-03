import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samples/chat_module/model/user_model.dart';
import 'package:samples/chat_module/utils/extension.dart';
import 'package:samples/chat_module/utils/firebase_keys.dart';
import 'package:samples/chat_module/view_model/auth_view_model.dart';

class ChatScreen extends StatefulWidget {
  final UserModel userModel;
  const ChatScreen({super.key, required this.userModel});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late AuthViewModel provider;
  String? currentUserId;
  String? recipientId;
  String chatDocId = '';
  User? user;

  initData() {
    currentUserId = FirebaseAuth.instance.currentUser?.uid;
    recipientId = widget.userModel.uid;
    user = FirebaseAuth.instance.currentUser;
    chatDocId = "${currentUserId ?? "__"}_${recipientId ?? "__"}";
  }

  void sendMessage({required Map<String, dynamic> params}) {
    provider.sendMessage(
        chatDocId: chatDocId, userDocId: currentUserId ?? "", params: params);
    provider.sendMessage(
        chatDocId: chatDocId, userDocId: recipientId ?? "", params: params);
  }

  void insertInUserDetails() {
    final createdAt = DateTime.now().toIso8601String();
    Map<String, dynamic> params = {
      FirebaseKeys.messagedRecipients: [
        {
          FirebaseKeys.chatDocId: chatDocId,
          FirebaseKeys.createdAt: createdAt,
          FirebaseKeys.recipientUID: recipientId,
          FirebaseKeys.chatCreatedBy: currentUserId,
        }
      ]
    };
    if (currentUserId != null) {
      provider.updateData(params: params, userId: currentUserId ?? "");
    }
    if (recipientId != null) {
      provider.updateData(params: params, userId: recipientId ?? "");
    }
  }

  // chatCreatedBy
  // recipient,
  // created_at,
  // chatDocId,

  @override
  void initState() {
    provider = context.read<AuthViewModel>();
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            widget.userModel.profileUrl != null
                ? SizedBox(
                    child: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            NetworkImage(widget.userModel.profileUrl!)),
                  )
                : const SizedBox(),
            10.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.userModel.firstName ?? ""),
                5.verticalSpace,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 270, minWidth: 0),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("user")
                          .doc(widget.userModel.uid)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        Map<String, dynamic>? data =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        String lastSeen = data?[FirebaseKeys.lastSeen] ?? "";
                        bool isOnline = data?[FirebaseKeys.isOnline] ?? false;
                        return Row(
                          children: isOnline
                              ? [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF00F701),
                                    ),
                                  ),
                                  5.horizontalSpace,
                                  const Text(
                                    "Online",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ]
                              : [
                                  Text(
                                    "Last seen today ${lastSeen.split("T").last}",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  )
                                ],
                        );
                      }),
                )
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Create Chat"),
          onPressed: () {
            final createdAt = DateTime.now().toIso8601String();
            Map<String, dynamic> params = {
              FirebaseKeys.createdAt: createdAt,
              FirebaseKeys.message: "Message",
              FirebaseKeys.messageStatus: "send",
              FirebaseKeys.messageSendBy: currentUserId,
            };
            insertInUserDetails();
            sendMessage(params: params);
          },
        ),
      ),
    );
  }
}
