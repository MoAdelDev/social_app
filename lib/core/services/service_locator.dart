import 'package:get_it/get_it.dart';
import 'package:social_app/modules/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:social_app/modules/authentication/data/repository/auth_repository.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';
import 'package:social_app/modules/authentication/domain/usecase/add_user_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/login_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/register_usecase.dart';
import 'package:social_app/modules/publish/data/datatsource/publish_remote_datasource.dart';
import 'package:social_app/modules/publish/data/repository/publish_repository.dart';
import 'package:social_app/modules/publish/domain/repository/base_publish_repository.dart';
import 'package:social_app/modules/publish/domain/usecases/publish_usecase.dart';

GetIt sl = GetIt.instance;

class ServiceLocator {
  init() {
    /// Data Sources
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());
    sl.registerLazySingleton<BasePublishRemoteDataSource>(
        () => PublishRemoteDataSource());

    /// Repositories
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<BasePublishRepository>(
        () => PublishRepository(sl()));

    /// Use Cases
    sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
    sl.registerLazySingleton<AddUserUseCase>(() => AddUserUseCase(sl()));
    sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
    sl.registerLazySingleton<PublishUseCase>(() => PublishUseCase(sl()));
  }
}
