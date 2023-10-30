import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';

abstract class BaseLikesRepository {
  Future<Either<Failure, List<User>>> getLikes({required String postId});
}