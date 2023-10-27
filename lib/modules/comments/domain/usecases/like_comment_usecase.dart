import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';

class LikeCommentUseCase {
  final BaseCommentsRepository baseCommentRepository;

  const LikeCommentUseCase(this.baseCommentRepository);

  Future<Either<Failure, void>> call({
    required Comment comment,
    required String uid,
    required bool isLiked,
  }) async =>
      await baseCommentRepository.likeComment(
        comment: comment,
        uid: uid,
        isLiked: isLiked,
      );
}
