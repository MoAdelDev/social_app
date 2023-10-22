import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class GetPostsLikesUseCase {
  final BaseHomeRepository baseHomeRepository;

  GetPostsLikesUseCase(this.baseHomeRepository);

  Future<Either<Failure, Map<String, int>>> call({
    required List<Post> posts,
  }) async =>
      await baseHomeRepository.getPostsLikes(
        posts: posts,
      );
}
