import 'package:get_it/get_it.dart';
import 'package:social_app/modules/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:social_app/modules/authentication/data/repository/auth_repository.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';
import 'package:social_app/modules/authentication/domain/usecase/add_user_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/login_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/register_usecase.dart';
import 'package:social_app/modules/home/data/datasource/home_remote_data_source.dart';
import 'package:social_app/modules/home/data/repository/home_repository.dart';
import 'package:social_app/modules/home/domain/repository/base_home_repository.dart';
import 'package:social_app/modules/home/domain/usecases/delete_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_is_liked_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_likes_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/get_posts_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/like_post_usecase.dart';
import 'package:social_app/modules/home/domain/usecases/publish_post_usecase.dart';

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

    sl.registerLazySingleton<GetPostsUseCase>(() => GetPostsUseCase(sl()));
    sl.registerLazySingleton<GetPostsUsersUseCase>(() => GetPostsUsersUseCase(sl()));
    sl.registerLazySingleton<PublishPostUseCase>(() => PublishPostUseCase(sl()));
    sl.registerLazySingleton<GetIsLikedPostUseCase>(() => GetIsLikedPostUseCase(sl()));
    sl.registerLazySingleton<LikePostUseCase>(() => LikePostUseCase(sl()));
    sl.registerLazySingleton<GetPostsLikesUseCase>(() => GetPostsLikesUseCase(sl()));
    sl.registerLazySingleton<DeletePostUseCase>(() => DeletePostUseCase(sl()));

  }
}
