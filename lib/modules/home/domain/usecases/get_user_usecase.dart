import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class GetUserUseCase {
  final BaseHomeRepository basePostRepository;

  GetUserUseCase(this.basePostRepository);

  Future<Either<Failure, User>> call({required String uid}) async =>
      await basePostRepository.getUser(uid: uid);
}
