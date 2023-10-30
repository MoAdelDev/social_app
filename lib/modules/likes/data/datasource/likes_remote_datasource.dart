import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/error/error_message_model.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';

abstract class BaseLikesRemoteDataSource {
  Future<List<UserModel>> getLikes({required String postId});
}

class LikesRemoteDataSource extends BaseLikesRemoteDataSource {
  @override
  Future<List<UserModel>> getLikes({required String postId}) async {
    final likesResult = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .where('like', isEqualTo: true)
        .get()
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    List<UserModel> users = [];
    for (var value in likesResult.docs) {
      final usersResult = await FirebaseFirestore.instance
          .collection('users')
          .doc(value.id)
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
      users.add(UserModel.formJson(usersResult.data() ?? {}));
    }
    return users;
  }
}
