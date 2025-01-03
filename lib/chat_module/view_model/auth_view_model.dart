import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:samples/chat_module/utils/firebase_keys.dart';
import 'package:samples/chat_module/repo/firebase_repo.dart';

class AuthViewModel extends ChangeNotifier {
  late FirebaseRepo repo;
  AuthViewModel(this.repo);

  bool isLogIn = true;

  String? errorMessage;
  UserCredential? credential;

  updateLoginStatus(bool value) {
    isLogIn = value;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    errorMessage = null;
    return await repo.login(email: email, password: password).fold((left) {
      errorMessage = left.message;
      print(errorMessage);
      return false;
    }, (right) {
      credential = right;
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> signIn({required String email, required String password}) async {
    errorMessage = null;
    return await repo.signIn(email: email, password: password).fold((left) {
      errorMessage = left.message;
      print(errorMessage);
      return false;
    }, (right) {
      credential = right;
      return true;
    }).catchError((e) {
      return false;
    });
  }

  bool isInsertingData = false;
  updateInsertingData(bool value) {
    isInsertingData = value;
    notifyListeners();
  }

  Future<bool> insertUserData({
    required Map<String, dynamic> params,
    required String userId,
  }) async {
    errorMessage = null;
    updateInsertingData(true);
    return await repo.insertData(collectionName: "user", params: params,userId: userId).fold(
        (left) {
      errorMessage = left.message;
      updateInsertingData(false);
      return false;
    }, (right) {
      updateInsertingData(false);
      return true;
    }).catchError((e) {
      updateInsertingData(false);
      return false;
    });
  }

  Future<bool> updateData({
    required Map<String,dynamic> params,
    required String userId,
}) async {
    errorMessage = null;
    return await repo
        .updateData(collectionName: "user", params: params, uid:userId)
        .fold((left) {
      errorMessage = left.message;
      return false;
    }, (right) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool?> checkUserIsFilledData() async {
    errorMessage = null;
    User? user = FirebaseAuth.instance.currentUser;
    return await repo.fetchData(collectionName: "user", uid: user?.uid).fold(
        (left) {
      errorMessage = left.message;
      return null;
    }, (right) {
      final jsonData = right.data() as Map<String, dynamic>?;
      bool? isDataFilled = jsonData?[FirebaseKeys.isUserDataFilled];
      return isDataFilled;
    }).catchError((e) {
      return null;
    });
  }

  /*<------------------------Fetching All Registered Users List-------------------------->*/
  bool isUsersFetching = false;
  updateIsUsersFetching(bool state) {
    isUsersFetching = state;
    notifyListeners();
  }

  List<QueryDocumentSnapshot> users = [];
  Future<bool?> fetchAllUsers() async {
    errorMessage = null;
    User? user = FirebaseAuth.instance.currentUser;
    users = [];
    updateIsUsersFetching(true);
    return await repo.getAllUsers(collectionName: "user").fold((left) {
      errorMessage = left.message;
      return null;
    }, (right) {
      QuerySnapshot snapshot = right;
      users.addAll(snapshot.docs);
      users.removeWhere((element) => element[FirebaseKeys.uid] == user?.uid);
      updateIsUsersFetching(false);
      return true;
    }).catchError((e) {
      updateIsUsersFetching(false);
      return null;
    });
  }

  Future<bool> updateUserOnlineStatus(bool isOnline) async {
    errorMessage = null;
    User? user = FirebaseAuth.instance.currentUser;
    final lastSeen = DateTime.now().toIso8601String();
    Map<String, dynamic> map = {
      FirebaseKeys.isOnline: isOnline,
      FirebaseKeys.lastSeen: lastSeen,
    };
    return await repo
        .updateData(collectionName: "user", params: map, uid: user?.uid)
        .fold((left) {
      errorMessage = left.message;
      return false;
    }, (right) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool> sendMessage({
    required String chatDocId,
    required String userDocId,
    required Map<String, dynamic> params,
  }) async {
    errorMessage = null;
    return await repo
        .createChat(
            baseCollectionName: "user",
            params: params,
            chatCollectionName: "chats",
            chatDocId: chatDocId,
            userDocId: userDocId)
        .fold((left) {
      errorMessage = left.message;
      return false;
    }, (right) {
      return true;
    }).catchError((e) {
      return false;
    });
  }
}
