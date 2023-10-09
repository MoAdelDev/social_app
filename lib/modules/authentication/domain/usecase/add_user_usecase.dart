import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';

class AddUserUseCase {
  final BaseAuthRepository baseAuthRepository;

  AddUserUseCase(this.baseAuthRepository);

  Future<Either<Failure, User>> call({required UserModel userModel}) async => await baseAuthRepository.addUser(userModel: userModel);
}