import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samples/chat_module/firebase_helper/firebase_requests.dart'
    as request;
import 'package:samples/chat_module/model/firebase_errors.dart';

abstract class FirebaseRepo {
  Future<Either<FirebaseError, UserCredential>> signIn(
      {required String email, required String password});

  Future<Either<FirebaseError, UserCredential>> login(
      {required String email, required String password});

  Future<Either<FirebaseError, bool>> insertData({
    required Map<String, dynamic> params,
    required String collectionName,
    required String userId,
  });

  Future<Either<FirebaseError, bool>> updateData({
    required Map<String, dynamic> params,
    required String collectionName,
    String? uid,
  });

  Future<Either<FirebaseError, DocumentSnapshot>> fetchData({
    required String collectionName,
    String? uid,
  });

  Future<Either<FirebaseError, QuerySnapshot>> getAllUsers(
      {required String collectionName});

  Future<Either<FirebaseError, bool>> createChat({
    required String baseCollectionName,
    required String chatCollectionName,
    required String userDocId,
    required String chatDocId,
    required Map<String, dynamic> params,
  });
}

class FirebaseRepoImplementation extends FirebaseRepo {
  @override
  Future<Either<FirebaseError, UserCredential>> login(
      {required String email, required String password}) async {
    return request.logInRequest(email: email, password: password);
  }

  @override
  Future<Either<FirebaseError, UserCredential>> signIn(
      {required String email, required String password}) {
    return request.signInRequest(email: email, password: password);
  }

  @override
  Future<Either<FirebaseError, bool>> insertData({
    required Map<String, dynamic> params,
    required String collectionName,
    required String userId,
  }) {
    return request.insertData(
      map: params,
      collectionName: collectionName,
      userId: userId,
    );
  }

  @override
  Future<Either<FirebaseError, bool>> updateData(
      {required Map<String, dynamic> params,
      required String collectionName,
      String? uid}) {
    return request.updateData(
        map: params, collectionName: collectionName, uid: uid);
  }

  @override
  Future<Either<FirebaseError, DocumentSnapshot>> fetchData(
      {required String collectionName, String? uid}) {
    return request.fetchData(collectionName: collectionName, uid: uid);
  }

  @override
  Future<Either<FirebaseError, QuerySnapshot>> getAllUsers(
      {required String collectionName}) {
    return request.fetchCollectionDocuments(collectionName: collectionName);
  }

  @override
  Future<Either<FirebaseError, bool>> createChat({
    required String baseCollectionName,
    required String chatCollectionName,
    required String userDocId,
    required String chatDocId,
    required Map<String, dynamic> params,
  }) {
    return request.createChat(
      baseCollectionName: baseCollectionName,
      chatCollectionName: chatCollectionName,
      userDocId: userDocId,
      chatDocId: chatDocId,
      params: params,
    );
  }
}
