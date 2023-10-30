import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/likes/domain/repository/base_likes_repository.dart';

class GetLikesUseCase {
  final BaseLikesRepository baseLikesRepository;

  const GetLikesUseCase(this.baseLikesRepository);

  Future<Either<Failure, List<User>>> call({required String postId}) async =>
      await baseLikesRepository.getLikes(postId: postId);
}
