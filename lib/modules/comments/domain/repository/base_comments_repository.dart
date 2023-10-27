import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';

abstract class BaseCommentsRepository {
  Future<Either<Failure, Comment>> addComment({required CommentModel commentModel});

  Future<Either<Failure, List<Comment>>> getComments({required String postId});

}