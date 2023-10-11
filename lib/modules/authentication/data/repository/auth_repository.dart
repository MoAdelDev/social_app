import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepository(this.baseAuthRemoteDataSource);

  @override
  Future<Either<Failure, String>> register(
      {required String email, required String password}) async {
    try {
      final result = await baseAuthRemoteDataSource.register(
          email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> addUser(
      {required UserModel userModel}) async {
    try {
      final result =
          await baseAuthRemoteDataSource.addUser(userModel: userModel);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, String>> login(
      {required String email, required String password}) async {
    try {
      final result = await baseAuthRemoteDataSource.login(
          email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>> getUser(
      {required String uid}) {
    try {
      final result = baseAuthRemoteDataSource.getUser(uid: uid);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}
