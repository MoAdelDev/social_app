import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/error/error_message_model.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';

import '../../domain/entities/comment.dart';

abstract class BaseCommentsRemoteDataSource {
  Future<CommentModel> addComment({required CommentModel commentModel});

  Future<List<CommentModel>> getComments({required String postId});

  Future<Map<String, User>> getCommentsUsers({required List<Comment> comments});

  Future<void> likeComment({
    required Comment comment,
    required String uid,
    required bool isLiked,
  });

  Future<Map<String, bool>> getIsCommentLiked({
    required List<Comment> comments,
    required String uid,
  });

  Future<Map<String, int>> getCommentsLikes({
    required List<Comment> comments,
    required String uid,
  });
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

  @override
  Future<Map<String, User>> getCommentsUsers(
      {required List<Comment> comments}) async {
    final Map<String, User> commentsUsers = {};
    for (var comment in comments) {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(comment.uid)
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
      commentsUsers
          .addAll({comment.id: UserModel.formJson(result.data() ?? {})});
    }
    return commentsUsers;
  }

  @override
  Future<void> likeComment(
      {required Comment comment,
      required String uid,
      required bool isLiked}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(comment.postId)
        .collection('comments')
        .doc(comment.id)
        .collection('likes')
        .doc(uid)
        .set({
      'like': isLiked,
    }).catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
  }

  @override
  Future<Map<String, bool>> getIsCommentLiked(
      {required List<Comment> comments, required String uid}) async {
    final Map<String, bool> isCommentLiked = {};
    for (Comment comment in comments) {
      final result = await FirebaseFirestore.instance
          .collection('posts')
          .doc(comment.postId)
          .collection('comments')
          .doc(comment.id)
          .collection('likes')
          .doc(uid)
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
      if (result.data() != null && result.data()?['like']) {
        isCommentLiked.addAll({comment.id: true});
      } else {
        isCommentLiked.addAll({comment.id: false});
      }
    }
    return isCommentLiked;
  }

  @override
  Future<Map<String, int>> getCommentsLikes(
      {required List<Comment> comments, required String uid}) async {
    final Map<String, int> commentsLikes = {};
    for (Comment comment in comments) {
      final result = await FirebaseFirestore.instance
          .collection('posts')
          .doc(comment.postId)
          .collection('comments')
          .doc(comment.id)
          .collection('likes')
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
      commentsLikes.addAll({comment.id: result.docs.length});
    }
    return commentsLikes;
  }
}
