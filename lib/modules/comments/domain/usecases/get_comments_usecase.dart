import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';

class GetCommentsUseCase {
  final BaseCommentsRepository baseCommentRepository;

  const GetCommentsUseCase(this.baseCommentRepository);

  Future<Either<Failure, List<Comment>>> call(
          {required String postId}) async =>
      baseCommentRepository.getComments(postId: postId);
}
