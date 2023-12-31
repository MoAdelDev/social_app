import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/router/app_router.dart';
import 'package:social_app/core/router/screen_arguments.dart';
import 'package:social_app/core/services/check_storage_permission_service.dart';
import 'package:social_app/core/utils/app_toast.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/generated/l10n.dart';
import 'package:social_app/main.dart';
import 'package:social_app/modules/home/data/models/post_model.dart';
import 'package:social_app/modules/home/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_is_liked_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_comments_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_saved_posts_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_user_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/like_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/publish_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/save_post_usecase.dart';
import 'package:social_app/modules/home/presentation/screens/posts_screen.dart';
import 'package:social_app/modules/messages/messages_screen.dart';
import 'package:social_app/modules/profile/profile_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';

import '../../../../authentication/domain/entities/user.dart' as user_entity;
import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_posts_likes_usecase.dart';
import '../../../domain/usecases/get_posts_users_usecase.dart';

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
  final SavePostUseCase savePostUseCase;
  final GetSavedPostsUseCase getSavedPostsUseCase;
  final GetUserUseCase getUserUseCase;
  final GetPostsCommentsUseCase getPostsCommentsUseCase;

  HomeBloc(
    this.getPostsUseCase,
    this.getPostsUsersUseCase,
    this.publishPostUseCase,
    this.likePostUseCase,
    this.getIsLikedPostUseCase,
    this.getPostsLikesUseCase,
    this.deletePostUseCase,
    this.savePostUseCase,
    this.getSavedPostsUseCase,
    this.getUserUseCase,
    this.getPostsCommentsUseCase,
  ) : super(const HomeState()) {
    on<HomeChangeBottomNavIndexEvent>(_changeBottomNavIndex);
    on<HomeGetUserEvent>(_getUser);
    on<HomePickImageFromCameraOrGalleryEvent>(_pickImage);
    on<HomeGetPostsEvent>(_getPosts);
    on<HomeGetPostsUsersEvent>(_getPostsUsers);
    on<HomePublishPostEvent>(_publishPost);
    on<HomeLoadPostsEvent>(_reloadPosts);
    on<HomeLikePostEvent>(_likePost);
    on<HomeGetIsLikedPostEvent>(_getIsLikedPost);
    on<HomeGetPostsLikesEvent>(_getPostsLikes);
    on<HomeGetSavedPostsEvent>(_getSavedPosts);
    on<HomeGetPostsCommentsEvent>(_getPostsComments);
    on<HomeDeletePostEvent>(_deletePost);
    on<HomeSavePostEvent>(_savePost);
  }

  FutureOr<void> _changeBottomNavIndex(
      HomeChangeBottomNavIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(
      currentIndex: event.index,
    ));
  }

  FutureOr<void> _pickImage(HomePickImageFromCameraOrGalleryEvent event,
      Emitter<HomeState> emit) async {
    if (await CheckStoragePermissionStorage.checkPermission(event.context)) {
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
      add(HomeGetSavedPostsEvent(
          event.posts, event.postsUsers, event.isLikedMap, postsLikes));
    });
  }

  FutureOr<void> _getSavedPosts(
      HomeGetSavedPostsEvent event, Emitter<HomeState> emit) async {
    final result = await getSavedPostsUseCase(
      posts: event.posts,
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
    );
    result.fold((failure) {
      AppToast.showToast(msg: failure.message, state: RequestState.error);
      emit(state.copyWith(
          postsError: failure.message, postsState: RequestState.error));
    }, (savedPosts) {
      add(HomeGetPostsCommentsEvent(
        event.posts,
        event.postsUsers,
        event.isLikedMap,
        event.postLikes,
        savedPosts,
      ));
    });
  }

  FutureOr<void> _getPostsComments(
      HomeGetPostsCommentsEvent event, Emitter<HomeState> emit) async {
    final result = await getPostsCommentsUseCase(
      posts: event.posts,
    );
    result.fold((failure) {
      AppToast.showToast(msg: failure.message, state: RequestState.error);
      emit(state.copyWith(
          postsError: failure.message, postsState: RequestState.error));
    }, (postsComments) {
      emit(state.copyWith(
        postsUsers: event.postsUsers,
        posts: event.posts,
        isLikedMap: event.isLikedMap,
        postsState: RequestState.success,
        postsLikes: event.postLikes,
        savedPosts: event.postsSaved,
        postsComments: postsComments,
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
      emit(state.copyWith(
        likeState: RequestState.success,
      ));
    });
  }

  FutureOr<void> _deletePost(
      HomeDeletePostEvent event, Emitter<HomeState> emit) async {
    String deleteSuccess = MyApp.isArabic
        ? "تم مسح المنشور بنجاح"
        : "The post delete successfully";
    String deleteFailed = MyApp.isArabic
        ? "فشل في مسح المنشور. حاول مرةً أخرى"
        : "Failed to delete the post. Try again";
    emit(state.copyWith(deletePostState: RequestState.loading));
    final result = await deletePostUseCase(postId: event.postId);
    result.fold((failure) {
      AppToast.showToast(msg: deleteFailed, state: RequestState.error);
      emit(state.copyWith(
          deletePostState: RequestState.error,
          deletePostError: failure.message));
    }, (_) {
      add(const HomeLoadPostsEvent());
      AppToast.showToast(msg: deleteSuccess, state: RequestState.success);
      emit(state.copyWith(
        deletePostState: RequestState.success,
      ));
    });
  }

  FutureOr<void> _savePost(
      HomeSavePostEvent event, Emitter<HomeState> emit) async {
    Map<String, bool> savedPosts = state.savedPosts;
    bool isSaved = !state.savedPosts[event.postId]!;
    savedPosts[event.postId] = isSaved;
    emit(state.copyWith(
      saveState: RequestState.loading,
      savedPosts: savedPosts,
    ));
    final result = await savePostUseCase(
      postId: event.postId,
      uid: FirebaseAuth.instance.currentUser?.uid ?? '',
      isSaved: isSaved,
    );
    result.fold((error) {
      Map<String, bool> savedPosts = state.savedPosts;
      bool isSaved = !state.savedPosts[event.postId]!;
      savedPosts[event.postId] = isSaved;
      emit(state.copyWith(
        saveState: RequestState.loading,
        savedPosts: savedPosts,
        saveError: error.message,
      ));
    }, (_) {
      emit(state.copyWith(
        saveState: RequestState.success,
      ));
    });
  }

  FutureOr<void> _getUser(
      HomeGetUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(userState: RequestState.loading));
    final result =
        await getUserUseCase(uid: FirebaseAuth.instance.currentUser?.uid ?? '');
    result.fold((error) {
      emit(state.copyWith(
          userState: RequestState.error, userError: error.message));
    }, (user) {
      MyApp.user = user;
      emit(state.copyWith(userState: RequestState.success, user: user));
    });
  }
}
