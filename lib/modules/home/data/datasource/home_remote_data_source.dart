import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/core/error/error_message_model.dart';
import 'package:social_app/core/error/server_exception.dart';
import 'package:social_app/modules/authentication/data/models/user_model.dart';
import 'package:social_app/modules/home/data/models/post_model.dart';
import 'package:social_app/modules/home/domain/entities/post.dart';

abstract class BaseHomeRemoteDataSource {
  Future<UserModel> getUser({required String uid});

  Future<void> publishPost({
    required PostModel postModel,
    required File imageFile,
  });

  Future<List<PostModel>> getPosts();

  Future<Map<String, UserModel>> getPostsUsers({required List<Post> posts});

  Future<Map<String, bool>> getIsLikedPost(
      {required List<Post> posts, required String uid});

  Future<Map<String, int>> getPostsLikes({required List<Post> posts});

  Future<void> likePost(
      {required String postId, required String uid, required bool isLiked});

  Future<void> deletePost({required String postId});

  Future<void> modifyPost(
      {required String postId,
      required String captionText,
      required File? imageFile});

  Future<void> savePost({
    required String postId,
    required String uid,
    required bool isSaved,
  });

  Future<Map<String, bool>> getSavedPosts(
      {required List<Post> posts, required String uid});
}

class HomeRemoteDataSource extends BaseHomeRemoteDataSource {
  @override
  Future<UserModel> getUser({required String uid}) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    return UserModel.formJson(result.data() ?? {});
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final result = await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .catchError((error) =>
            throw ServerException(ErrorMessageModel(error.toString())));
    return List.from(result.docs.map((e) {
      return PostModel.fromJson(e.data());
    }));
  }

  @override
  Future<Map<String, UserModel>> getPostsUsers(
      {required List<Post> posts}) async {
    Map<String, UserModel> usersMap = {};
    for (Post post in posts) {
      String id = post.id;
      final result =
          await FirebaseFirestore.instance.collection('posts').doc(id).get();
      String uid = result.data()?['uid'];
      final userResult =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      usersMap.addAll({id: UserModel.formJson(userResult.data() ?? {})});
    }
    return usersMap;
  }

  @override
  Future<void> publishPost(
      {required PostModel postModel, required File imageFile}) async {
    final result = await FirebaseStorage.instance
        .ref('posts')
        .child(postModel.id)
        .putFile(imageFile)
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
    final image = await result.ref.getDownloadURL();
    PostModel post = PostModel(
      postModel.id,
      postModel.captionText,
      image,
      postModel.date,
      postModel.uid,
    );
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(post.id)
        .set(post.toJson())
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
  }

  @override
  Future<void> likePost(
      {required String postId,
      required String uid,
      required bool isLiked}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(uid)
        .set({'like': isLiked}).catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
  }

  @override
  Future<Map<String, bool>> getIsLikedPost(
      {required List<Post> posts, required String uid}) async {
    Map<String, bool> isLikedMap = {};
    for (Post post in posts) {
      final result = await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .collection('likes')
          .doc(uid)
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });

      if (result.data() != null && result.data()?['like']) {
        isLikedMap.addAll({post.id: true});
      } else {
        isLikedMap.addAll({post.id: false});
      }
    }
    return isLikedMap;
  }

  @override
  Future<Map<String, int>> getPostsLikes({required List<Post> posts}) async {
    Map<String, int> likesMap = {};
    for (Post post in posts) {
      final result = await FirebaseFirestore.instance
          .collection('posts')
          .doc(post.id)
          .collection('likes')
          .where('like', isEqualTo: true)
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
      likesMap.addAll({post.id: result.docs.length});
    }
    return likesMap;
  }

  @override
  Future<void> deletePost({required String postId}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
  }

  @override
  Future<void> modifyPost({
    required String postId,
    required String captionText,
    required File? imageFile,
  }) async {
    String imageUrl = '';
    if (imageFile != null) {
      final imageResult = await FirebaseStorage.instance
          .ref('posts')
          .child(postId)
          .putFile(imageFile);
      imageUrl = await imageResult.ref.getDownloadURL();
    }
    Map<String, dynamic> dataWithoutImage = {
      'captionText': captionText,
    };
    Map<String, dynamic> dataWithImage = {
      'captionText': captionText,
      'image': imageUrl,
    };
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(imageUrl == '' ? dataWithoutImage : dataWithImage)
        .catchError((error) {
      throw ServerException(ErrorMessageModel(error.toString()));
    });
  }

  @override
  Future<void> savePost(
      {required String postId, required String uid, required isSaved}) async {
    if (!isSaved) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved_posts')
          .where('postId', isEqualTo: postId)
          .get()
          .then((value) {
        for (var save in value.docs) {
          save.reference.delete();
        }
      }).catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
    } else {
      final saveId = DateTime.now().millisecondsSinceEpoch;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved_posts')
          .doc(saveId.toString())
          .set({'postId': postId}).catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
    }
  }

  @override
  Future<Map<String, bool>> getSavedPosts(
      {required List<Post> posts, required String uid}) async {
    Map<String, bool> savedPosts = {};
    for (Post post in posts) {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved_posts')
          .where('postId', isEqualTo: post.id)
          .get()
          .catchError((error) {
        throw ServerException(ErrorMessageModel(error.toString()));
      });
      if (result.docs.isNotEmpty) {
        savedPosts.addAll({post.id: true});
      } else {
        savedPosts.addAll({post.id: false});
      }
    }
    return savedPosts;
  }
}
