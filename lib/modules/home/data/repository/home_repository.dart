import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/home/data/datasource/home_remote_datasource.dart';
import 'package:social_app/modules/home/data/models/post_model.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';

class HomeRepository extends BaseHomeRepository {
  final BaseHomeRemoteDataSource basePostRemoteDataSource;

  HomeRepository(this.basePostRemoteDataSource);

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    try {
      final result = await basePostRemoteDataSource.getPosts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, User>>> getUsersPosts(
      {required List<Post> posts}) async {
    try {
      final result = await basePostRemoteDataSource.getPostsUsers(posts: posts);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> publishPost(
      {required PostModel postModel, required File imageFile}) async {
    try {
      final result = await basePostRemoteDataSource.publishPost(
          postModel: postModel, imageFile: imageFile);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}
