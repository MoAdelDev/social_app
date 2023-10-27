import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class GetSavedPostsUseCase {
  final BaseHomeRepository baseHomeRepository;

  GetSavedPostsUseCase(this.baseHomeRepository);

  Future<Either<Failure, Map<String, bool>>> call({
    required List<Post> posts,
    required String uid,
  }) async =>
      await baseHomeRepository.getSavedPosts(
        posts: posts,
        uid: uid,
      );
}
