import 'package:either_dart/either.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/comments/data/datasource/comments_remote_datasource.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/comment.dart';
import '../models/comment_model.dart';

class CommentsRepository extends BaseCommentsRepository {
  final BaseCommentsRemoteDataSource baseCommentRemoteDataSource;

  CommentsRepository(this.baseCommentRemoteDataSource);

  @override
  Future<Either<Failure, Comment>> addComment(
      {required CommentModel commentModel}) async {
    try {
      final result = await baseCommentRemoteDataSource.addComment(
          commentModel: commentModel);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getComments(
      {required String postId}) async {
    try {
      final result = await baseCommentRemoteDataSource.getComments(
        postId: postId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}
