import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

import '../entities/post.dart';

class GetPostsUsersUseCase {
  final BaseHomeRepository basePostRepository;

  GetPostsUsersUseCase(this.basePostRepository);

  Future<Either<Failure, Map<String, User>>> call({
    required List<Post> posts,
  }) async =>
      await basePostRepository.getUsersPosts(posts: posts);
}
