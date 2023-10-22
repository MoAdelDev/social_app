import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:social_app/core/error/failure.dart';
import 'package:social_app/modules/authentication/domain/entities/user.dart';
import 'package:social_app/modules/home/data/models/post_model.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';

abstract class BaseHomeRepository {
  Future<Either<Failure, List<Post>>> getPosts();

  Future<Either<Failure, Map<String, User>>> getUsersPosts(
      {required List<Post> posts});

  Future<Either<Failure, void>> publishPost(
      {required PostModel postModel, required File imageFile});

  Future<Either<Failure, Map<String, bool>>> getIsLikedPost(
      {required List<Post> posts, required String uid});

  Future<Either<Failure, Map<String, int>>> getPostsLikes(
      {required List<Post> posts,});


  Future<Either<Failure, void>> likePost(
      {required String postId, required String uid, required bool isLiked});
}
