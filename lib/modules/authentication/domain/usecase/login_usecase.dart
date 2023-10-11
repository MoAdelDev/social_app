import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';

class LoginUseCase {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase(this.baseAuthRepository);

  Future<Either<Failure, String>> call(
          {required String email, required String password}) async =>
      await baseAuthRepository.login(email: email, password: password);
}
