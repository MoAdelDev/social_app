import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/home/data/models/post_model.dart';
import 'package:social_app/modules/home/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_is_liked_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/like_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/publish_post_usecase.dart';
import 'package:social_app/modules/home/presentation/screens/posts_screen.dart';
import 'package:social_app/modules/messages/messages_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';

import '../../../authentication/domain/entities/user.dart' as user_entity;
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts_likes_usecase.dart';
import '../../domain/usecases/get_posts_users_usecase.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<BaseHomeEvent, HomeState> {
  final GetPostsUseCase getPostsUseCase;
  final GetPostsUsersUseCase getPostsUsersUseCase;
  final GetIsLikedPostUseCase getIsLikedPostUseCase;
  final PublishPostUseCase publishPostUseCase;
  final LikePostUseCase likePostUseCase;
  final GetPostsLikesUseCase getPostsLikesUseCase;
  final DeletePostUseCase deletePostUseCase;

  HomeBloc(
    this.getPostsUseCase,
    this.getPostsUsersUseCase,
    this.publishPostUseCase,
    this.likePostUseCase,
    this.getIsLikedPostUseCase,
    this.getPostsLikesUseCase,
    this.deletePostUseCase,
  ) : super(const HomeState()) {
    on<HomeChangeBottomNavIndexEvent>(_changeBottomNavIndex);
    on<HomePickImageFromCameraOrGalleryEvent>(_pickImage);
    on<HomeGetPostsEvent>(_getPosts);
    on<HomeGetPostsUsersEvent>(_getPostsUsers);
    on<HomePublishPostEvent>(_publishPost);
    on<HomeLoadPostsEvent>(_reloadPosts);
    on<HomeLikePostEvent>(_likePost);
    on<HomeGetIsLikedPostEvent>(_getIsLikedPost);
    on<HomeGetPostsLikesEvent>(_getPostsLikes);
    on<HomeDeletePostEvent>(_deletePost);
  }

  FutureOr<void> _changeBottomNavIndex(
      HomeChangeBottomNavIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentIndex: event.index));
  }

  FutureOr<void> _pickImage(HomePickImageFromCameraOrGalleryEvent event,
      Emitter<HomeState> emit) async {
    if (await _checkPermission(event.context)) {
      XFile? imagePicked;
      if (event.isCamera) {
        imagePicked = await ImagePicker().pickImage(source: ImageSource.camera);
      } else {
        imagePicked =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      }
      if (imagePicked != null) {
        ScreenArguments screenArguments =
            ScreenArguments.toPublishScreen(imageFile: File(imagePicked.path));
        if (event.context.mounted) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(
            event.context,
            AppRouter.kPublishScreen,
            arguments: screenArguments,
          );
        }
      }
    }
  }

  Future<bool> _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos
    ].request();

    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage = statues[Permission.storage];
    PermissionStatus? statusPhotos = statues[Permission.photos];
    bool isGranted = statusCamera == PermissionStatus.granted &&
        statusStorage == PermissionStatus.granted &&
        statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      return true;
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
            statusStorage == PermissionStatus.permanentlyDenied ||
            statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      return false;
    }
    return true;
  }

  FutureOr<void> _publishPost(
      HomePublishPostEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(publishState: RequestState.loading));
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    DateTime now = DateTime.now();
    String date = DateFormat.yMd().add_jm().format(now);
    PostModel postModel = PostModel(
      id,
      event.captionText,
      '',
      date,
      FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    final result = await publishPostUseCase(
      postModel: postModel,
      imageFile: event.imageFile,
    );
    result.fold((error) {
      AppToast.showToast(msg: error.message, state: RequestState.error);
      emit(state.copyWith(
          publishError: error.message, publishState: RequestState.error));
    }, (right) {
      AppToast.showToast(
          msg: S.of(event.context).postSuccessMsg, state: RequestState.success);
      add(const HomeGetPostsEvent());
      Navigator.pop(event.context);
      emit(state.copyWith(publishState: RequestState.success));
    });
  }

  FutureOr<void> _getPosts(
      HomeGetPostsEvent event, Emitter<HomeState> emit) async {
    final result = await getPostsUseCase();
    result.fold((failure) {
      AppToast.showToast(msg: failure.message, state: RequestState.error);
      emit(state.copyWith(
          postsError: failure.message, postsState: RequestState.error));
    }, (posts) {
      add(HomeGetPostsUsersEvent(posts));
    });
  }

  FutureOr<void> _getPostsUsers(
      HomeGetPostsUsersEvent event, Emitter<HomeState> emit) async {
    final result = await getPostsUsersUseCase(posts: event.posts);
    result.fold((failure) {
      AppToast.showToast(msg: failure.message, state: RequestState.error);
      emit(state.copyWith(
          postsError: failure.message, postsState: RequestState.error));
    }, (postsUsers) {
      add(HomeGetIsLikedPostEvent(event.posts, postsUsers));
    });
  }

  FutureOr<void> _getIsLikedPost(
      HomeGetIsLikedPostEvent event, Emitter<HomeState> emit) async {
    final result = await getIsLikedPostUseCase(
        posts: event.posts, uid: FirebaseAuth.instance.currentUser?.uid ?? '');
    result.fold((failure) {
      AppToast.showToast(msg: failure.message, state: RequestState.error);
      emit(state.copyWith(
          postsError: failure.message, postsState: RequestState.error));
    }, (isLikedMap) {
      add(HomeGetPostsLikesEvent(event.posts, event.postsUsers, isLikedMap));
    });
  }

  FutureOr<void> _getPostsLikes(
      HomeGetPostsLikesEvent event, Emitter<HomeState> emit) async {
    final result = await getPostsLikesUseCase(posts: event.posts);
    result.fold((failure) {
      AppToast.showToast(msg: failure.message, state: RequestState.error);
      emit(state.copyWith(
          postsError: failure.message, postsState: RequestState.error));
    }, (postsLikes) {
      emit(state.copyWith(
        postsUsers: event.postsUsers,
        posts: event.posts,
        isLikedMap: event.isLikedMap,
        postsState: RequestState.success,
        postsLikes: postsLikes,
        isLoading: false,
      ));
    });
  }

  FutureOr<void> _reloadPosts(
      HomeLoadPostsEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isLoading: true));
    add(const HomeGetPostsEvent());
  }

  FutureOr<void> _likePost(
      HomeLikePostEvent event, Emitter<HomeState> emit) async {
    Map<String, bool> isLikedMap = state.isLikedMap;
    Map<String, int> postsLikes = state.postsLikes;
    bool isLiked = !state.isLikedMap[event.postId]!;
    if (isLiked) {
      postsLikes[event.postId] = postsLikes[event.postId]! + 1;
    } else {
      postsLikes[event.postId] = postsLikes[event.postId]! - 1;
    }
    isLikedMap[event.postId] = isLiked;
    emit(state.copyWith(
      likeState: RequestState.loading,
      isLikedMap: isLikedMap,
      postsLikes: postsLikes,
    ));
    final result = await likePostUseCase(
      postId: event.postId,
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
      isLiked: isLiked,
    );
    result.fold((error) {
      Map<String, bool> isLikedMap = state.isLikedMap;
      Map<String, int> postsLikes = state.postsLikes;
      bool isLiked = !state.isLikedMap[event.postId]!;
      if (isLiked) {
        postsLikes[event.postId] = postsLikes[event.postId]! + 1;
      } else {
        postsLikes[event.postId] = postsLikes[event.postId]! - 1;
      }
      isLikedMap[event.postId] = isLiked;
      emit(state.copyWith(
        likeState: RequestState.error,
        likeError: error.message,
        isLikedMap: isLikedMap,
        postsLikes: postsLikes,
      ));
    }, (_) {
      add(const HomeGetPostsEvent());
      emit(state.copyWith(
        likeState: RequestState.success,
      ));
    });
  }

  FutureOr<void> _deletePost(
      HomeDeletePostEvent event, Emitter<HomeState> emit) async {
    String deleteSuccess = MyApp.isArabic ? "تم مسح المنشور بنجاح" : "The post delete successfully";
    String deleteFailed = MyApp.isArabic ? "فشل في مسح المنشور. حاول مرةً أخرى" : "Failed to delete the post. Try again";
    emit(state.copyWith(deletePostState: RequestState.loading));
    final result = await deletePostUseCase(postId: event.postId);
    result.fold((failure) {
      AppToast.showToast(
          msg: deleteFailed,
          state: RequestState.error);
      emit(state.copyWith(
          deletePostState: RequestState.error,
          deletePostError: failure.message));
    }, (_) {
      add(const HomeLoadPostsEvent());
      AppToast.showToast(
          msg: deleteSuccess,
          state: RequestState.success);
      emit(state.copyWith(
        deletePostState: RequestState.success,
      ));
    });
  }
}
