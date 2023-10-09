
import 'package:get_it/get_it.dart';
import 'package:social_app/modules/authentication/data/datasource/auth_remote_datasource.dart';
import 'package:social_app/modules/authentication/data/repository/auth_repository.dart';
import 'package:social_app/modules/authentication/domain/repository/base_auth_repository.dart';
import 'package:social_app/modules/authentication/domain/usecase/add_user_usecase.dart';
import 'package:social_app/modules/authentication/domain/usecase/register_usecase.dart';

GetIt sl = GetIt.instance;

class ServiceLocator{

  init(){

    /// Data Sources
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(() => AuthRemoteDataSource());

    /// Repositories
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));



    /// Use Cases
    sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
    sl.registerLazySingleton<AddUserUseCase>(() => AddUserUseCase(sl()));

  }
}