import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';

class RegisterUseCase {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase(this.baseAuthRepository);

  Future<Either<Failure, String>> call({required email, required password}) async => await baseAuthRepository.register(email: email, password: password);
}