import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/home/data/datasource/home_remote_data_source.dart';
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

  @override
  Future<Either<Failure, void>> likePost(
      {required String postId,
      required String uid,
      required bool isLiked}) async {
    try {
      final result = await basePostRemoteDataSource.likePost(
          postId: postId, uid: uid, isLiked: isLiked);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, bool>>> getIsLikedPost(
      {required List<Post> posts, required String uid}) async {
    try {
      final result =
          await basePostRemoteDataSource.getIsLikedPost(posts: posts, uid: uid);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, int>>> getPostsLikes(
      {required List<Post> posts}) async {
    try {
      final result = await basePostRemoteDataSource.getPostsLikes(posts: posts);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }

  @override
  Future<Either<Failure, void>> deletePost({required String postId}) async {
    try {
      final result = await basePostRemoteDataSource.deletePost(postId: postId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorMessageModel.message));
    }
  }
}
