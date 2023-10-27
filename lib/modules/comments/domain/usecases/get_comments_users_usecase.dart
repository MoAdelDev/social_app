import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';

class GetCommentUsersUseCase {
  final BaseCommentsRepository baseCommentRepository;

  const GetCommentUsersUseCase(this.baseCommentRepository);

  Future<Either<Failure, Map<String, User>>> call(
          {required List<Comment> comments}) async =>
      await baseCommentRepository.getCommentsUsers(comments: comments);
}
