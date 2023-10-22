import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

import '../entities/post.dart';

class GetPostsUseCase {
  final BaseHomeRepository basePostRepository;

  GetPostsUseCase(this.basePostRepository);

  Future<Either<Failure, List<Post>>> call() async =>
      await basePostRepository.getPosts();
}
