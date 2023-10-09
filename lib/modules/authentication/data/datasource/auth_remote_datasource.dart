import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/core/error/error_message_model.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAuthRemoteDataSource {
  Future<String> register({required email, required password});

  Future<UserModel> addUser({required UserModel userModel});

  Future<String> login({required String email, required String password});

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser({required String uid});
}

class AuthRemoteDataSource extends BaseAuthRemoteDataSource {
  @override
  Future<String> register({required email, required password}) async {
    final result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    return result.user!.uid;
  }

  @override
  Future<UserModel> addUser({required UserModel userModel}) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(userModel.toJson())
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    return userModel;
  }

  @override
  Future<String> login(
      {required String email, required String password}) async {
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });

    return result.user!.uid;
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser({required String uid})  {
    final result = FirebaseFirestore.instance.collection('users').doc(uid).snapshots();
    return result;
  }
}
