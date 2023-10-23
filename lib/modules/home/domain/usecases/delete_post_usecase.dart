import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class DeletePostUseCase {
  final BaseHomeRepository baseHomeRepository;

  DeletePostUseCase(this.baseHomeRepository);

  Future<Either<Failure, void>> call({
    required String postId,
  }) async =>
      await baseHomeRepository.deletePost(
        postId: postId,
      );
}
