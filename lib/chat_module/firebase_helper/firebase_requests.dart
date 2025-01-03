import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:samples/chat_module/model/firebase_errors.dart';

Future<Either<FirebaseError, UserCredential>> signInRequest(
    {required String email, required String password}) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return Right(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return Left(
          FirebaseError("weak-password", "The password provided is too weak."));
    } else if (e.code == 'email-already-in-use') {
      return Left(FirebaseError("email-already-in-use",
          "The account already exists for that email."));
    }
  } catch (e) {
    return Left(FirebaseError("error", e.toString()));
  }
  return Left(FirebaseError("error", "Something went wrong."));
}

Future<Either<FirebaseError, UserCredential>> logInRequest(
    {required String email, required String password}) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return Right(credential);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return Left(
          FirebaseError("user-not-found", "No user found for that email."));
    } else if (e.code == 'wrong-password') {
      return Left(FirebaseError(
          "wrong-password", "Wrong password provided for that user."));
    }
  }

  return Left(FirebaseError("error", "Something went wrong."));
}

Future<Either<FirebaseError, bool>> insertData({
  required Map<String, dynamic> map,
  required String collectionName,
  required String userId,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    await collectionReference.doc(userId).set(map);
    return const Right(true);
  } on FirebaseAuthException catch (e) {
    return Left(FirebaseError("error", e.toString()));
  }
}

Future<Either<FirebaseError, bool>> updateData({
  required Map<String, dynamic> map,
  required String collectionName,
  String? uid,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    await collectionReference.doc(uid).update(map);
    return const Right(true);
  } on FirebaseAuthException catch (e) {
    return Left(FirebaseError("error", e.toString()));
  }
}

Future<Either<FirebaseError, DocumentSnapshot>> fetchData({
  required String collectionName,
  String? uid,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    DocumentSnapshot data = await collectionReference.doc(uid).get();
    return Right(data);
  } on FirebaseAuthException catch (e) {
    return Left(FirebaseError("error", e.toString()));
  }
}

Future<Either<FirebaseError, QuerySnapshot>> fetchCollectionDocuments({
  required String collectionName,
}) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collectionName);
  try {
    QuerySnapshot data = await collectionReference.get();
    return Right(data);
  } on FirebaseAuthException catch (e) {
    return Left(FirebaseError("error", e.toString()));
  }
}

Future<Either<FirebaseError, bool>> createChat(
    {required String baseCollectionName,
    required String chatCollectionName,
    required String userDocId,
    required String chatDocId,
    required Map<String, dynamic> params,}) async {
  CollectionReference collectionReference = FirebaseFirestore.instance
      .collection(baseCollectionName)
      .doc(userDocId)
      .collection(chatCollectionName);
  try {
    await collectionReference.doc(chatDocId).set(params);
    return const Right(true);
  } on FirebaseAuthException catch (e) {
    return Left(FirebaseError("error", e.toString()));
  }
}
