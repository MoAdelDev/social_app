import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';

abstract class BaseCommentsRepository {
  Future<Either<Failure, Comment>> addComment(
      {required CommentModel commentModel});

  Future<Either<Failure, List<Comment>>> getComments({required String postId});

  Future<Either<Failure, Map<String, User>>> getCommentsUsers({
    required List<Comment> comments,
  });

  Future<Either<Failure, void>> likeComment({
    required Comment comment,
    required String uid,
    required bool isLiked,
  });

  Future<Either<Failure, Map<String, bool>>> getIsCommentLiked({
    required List<Comment> comments,
    required String uid,
  });

  Future<Either<Failure, Map<String, int>>> getCommentsLikes({
    required List<Comment> comments,
    required String uid,
  });
}
