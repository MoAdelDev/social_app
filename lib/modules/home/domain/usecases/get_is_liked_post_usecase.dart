import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class GetIsLikedPostUseCase {
  final BaseHomeRepository baseHomeRepository;

  GetIsLikedPostUseCase(this.baseHomeRepository);

  Future<Either<Failure, Map<String, bool>>> call(
          {required List<Post> posts, required String uid}) async =>
      await baseHomeRepository.getIsLikedPost(
        posts: posts,
        uid: uid,
      );
}
