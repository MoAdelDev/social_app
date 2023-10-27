import 'package:get_it/get_it.dart';
import 'package:social_app/modules/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:social_app/modules/authentication/data/repository/auth_repository.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';
import 'package:social_app/modules/authentication/domain/usecase/add_user_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/login_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/register_usecase.dart';
import 'package:social_app/modules/comments/data/datasource/comments_remote_datasource.dart';
import 'package:social_app/modules/comments/data/repository/comments_repository.dart';
import 'package:social_app/modules/comments/domain/repository/base_comments_repository.dart';
import 'package:social_app/modules/comments/domain/usecases/add_comment_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_likes_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_comments_users_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/get_is_comment_liked_usecase.dart';
import 'package:social_app/modules/comments/domain/usecases/like_comment_usecase.dart';
import 'package:social_app/modules/home/data/datasource/home_remote_data_source.dart';
import 'package:social_app/modules/home/data/repository/home_repository.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';
import 'package:social_app/modules/home/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_is_liked_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_likes_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_saved_posts_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_user_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/like_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/modify_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/publish_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/save_post_usecase.dart';

import '../../modules/home/domain/usecases/get_posts_users_usecase.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  init() {
    /// Authentication
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());

    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));

    sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
    sl.registerLazySingleton<AddUserUseCase>(() => AddUserUseCase(sl()));
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));

    /// Home
    sl.registerLazySingleton<BaseHomeRemoteDataSource>(
        () => HomeRemoteDataSource());

    sl.registerLazySingleton<BaseHomeRepository>(() => HomeRepository(sl()));

    sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(sl()));
    sl.registerLazySingleton<GetPostsUseCase>(() => GetPostsUseCase(sl()));
    sl.registerLazySingleton<GetPostsUsersUseCase>(
        () => GetPostsUsersUseCase(sl()));
    sl.registerLazySingleton<PublishPostUseCase>(
        () => PublishPostUseCase(sl()));
    sl.registerLazySingleton<GetIsLikedPostUseCase>(
        () => GetIsLikedPostUseCase(sl()));
    sl.registerLazySingleton<LikePostUseCase>(() => LikePostUseCase(sl()));
    sl.registerLazySingleton<GetPostsLikesUseCase>(
        () => GetPostsLikesUseCase(sl()));
    sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(sl()));
    sl.registerLazySingleton<ModifyPostUseCase>(() => ModifyPostUseCase(sl()));
    sl.registerLazySingleton<SavePostUseCase>(() => SavePostUseCase(sl()));
    sl.registerLazySingleton<GetSavedPostsUseCase>(
        () => GetSavedPostsUseCase(sl()));

    /// Comments
    sl.registerLazySingleton<BaseCommentsRemoteDataSource>(
        () => CommentsRemoteDataSource());

    sl.registerLazySingleton<BaseCommentsRepository>(
        () => CommentsRepository(sl()));

    sl.registerLazySingleton<AddCommentUseCase>(() => AddCommentUseCase(sl()));
    sl.registerLazySingleton<GetCommentsUseCase>(
        () => GetCommentsUseCase(sl()));
    sl.registerLazySingleton<GetCommentUsersUseCase>(
        () => GetCommentUsersUseCase(sl()));
    sl.registerLazySingleton<GetIsCommentLikedIsUseCase>(
            () => GetIsCommentLikedIsUseCase(sl()));
    sl.registerLazySingleton<GetCommentsLikesUseCase>(
            () => GetCommentsLikesUseCase(sl()));
    sl.registerLazySingleton<LikeCommentUseCase>(
            () => LikeCommentUseCase(sl()));
  }
}
