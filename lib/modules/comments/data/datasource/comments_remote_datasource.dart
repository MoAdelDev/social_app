import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/error/error_message_model.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';

abstract class BaseCommentsRemoteDataSource {
  Future<CommentModel> addComment({required CommentModel commentModel});

  Future<List<CommentModel>> getComments({required String postId});
}

class CommentsRemoteDataSource extends BaseCommentsRemoteDataSource {
  @override
  Future<CommentModel> addComment({required CommentModel commentModel}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(commentModel.postId)
        .collection('comments')
        .doc(commentModel.id)
        .set(commentModel.toJson())
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    return commentModel;
  }

  @override
  Future<List<CommentModel>> getComments({required String postId}) async {
    final result = await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    return List.from((result.docs).map((e) => CommentModel.fromJson(e.data())));
  }
}
