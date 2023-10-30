import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/likes/data/datasource/likes_remote_datasource.dart';
import 'package:social_app/modules/likes/domain/repository/base_likes_repository.dart';

class LikesRepository extends BaseLikesRepository {
  final BaseLikesRemoteDataSource baseLikesRemoteDataSource;

  LikesRepository(this.baseLikesRemoteDataSource);

  @override
  Future<Either<Failure, List<User>>> getLikes({required String postId}) async {
    try {
      final result = await baseLikesRemoteDataSource.getLikes(postId: postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}
