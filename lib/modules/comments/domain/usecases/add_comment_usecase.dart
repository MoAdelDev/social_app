import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/comments/data/models/comment_model.dart';
import 'package:social_app/modules/comments/domain/entities/comment.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';

class AddCommentUseCase {
  final BaseCommentsRepository baseCommentRepository;

  const AddCommentUseCase(this.baseCommentRepository);

  Future<Either<Failure, Comment>> call(
          {required CommentModel commentModel}) async =>
     await  baseCommentRepository.addComment(commentModel: commentModel);
}
