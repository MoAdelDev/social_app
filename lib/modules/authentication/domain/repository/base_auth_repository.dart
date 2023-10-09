import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';

abstract class BaseAuthRepository {

  Future<Either<Failure, String>> register({required String email, required String password});

  Future<Either<Failure, User>> addUser({required UserModel userModel});


}