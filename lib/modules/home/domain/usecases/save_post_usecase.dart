import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class SavePostUseCase {
  final BaseHomeRepository baseHomeRepository;

  SavePostUseCase(this.baseHomeRepository);

  Future<Either<Failure, void>> call(
          {required String postId,
          required String uid,
          required bool isSaved}) async =>
      await baseHomeRepository.savePost(
        postId: postId,
        uid: uid,
        isSaved: isSaved,
      );
}
