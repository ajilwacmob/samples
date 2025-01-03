import 'package:samples/chat_module/utils/firebase_keys.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? profileUrl;
  String? bio;
  String? uid;
  String? token;
  UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.bio,
    this.profileUrl,
    this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      uid: data[FirebaseKeys.uid],
      firstName: data[FirebaseKeys.firstName],
      lastName: data[FirebaseKeys.lastName],
      bio: data[FirebaseKeys.bio],
      profileUrl: data[FirebaseKeys.profileUrl],
      token: data[FirebaseKeys.token],
    );
  }
}
