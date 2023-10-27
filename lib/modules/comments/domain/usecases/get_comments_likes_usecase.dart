import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';

class GetCommentsLikesUseCase {
  final BaseCommentsRepository baseCommentRepository;

  const GetCommentsLikesUseCase(this.baseCommentRepository);

  Future<Either<Failure, Map<String, int>>> call({
    required List<Comment> comments,
    required String uid,
  }) async =>
      await baseCommentRepository.getCommentsLikes(
        comments: comments,
        uid: uid,
      );
}
