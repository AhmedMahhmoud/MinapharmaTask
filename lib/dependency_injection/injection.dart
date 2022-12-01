import 'package:get_it/get_it.dart';
import 'package:pharmatask/Core/Network/network_connection_checker.dart';
import 'package:pharmatask/features/Authentication/data/auth_repo_impl/auth_repo_imp.dart';
import 'package:pharmatask/features/Authentication/domain/repository/auth_repo.dart';
import 'package:pharmatask/features/Authentication/domain/usecases/login_usecase.dart';
import 'package:pharmatask/features/Authentication/domain/usecases/sign_up_usecase.dart';
import 'package:pharmatask/features/Authentication/presentation/cubit/authentication_cubit.dart';
import 'package:pharmatask/features/Movies/Data/Datasource/movies_local_datasource.dart';
import 'package:pharmatask/features/Movies/Data/Datasource/movies_remote_datasource.dart';
import 'package:pharmatask/features/Movies/Data/Repository/movies_repo_imp.dart';
import 'package:pharmatask/features/Movies/Domain/Repository/movies_repo.dart';
import 'package:pharmatask/features/Movies/Domain/Usecases/get_movies_usecase.dart';
import 'package:pharmatask/features/Movies/Presentation/cubit/movies_cubit.dart';
import 'package:pharmatask/services/sembast_database/Auth/authentication_db.dart';
import 'package:pharmatask/services/sembast_database/Movies/movies_db.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;
Future<void> init() async {
  // Bloc
  sl.registerFactory(
      () => AuthenticationCubit(loginUsecase: sl(), signUpUsecase: sl()));
  sl.registerFactory(() => MoviesCubit(sl()));
  //usecases
  //?Authentication
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  //?Movies
  sl.registerLazySingleton(() => GetMoviesUsecase(sl()));
  //Datasource
  sl.registerLazySingleton(() => MovieRemoteDataSource());
  sl.registerLazySingleton(() => MoviesLocalDataSource(moviesDao: sl()));
  //Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(sl()));
  sl.registerLazySingleton<MoviesRepository>(() => MovieRepositoryImpl(
      movieRemoteDataSource: sl(),
      moviesLocalDataSource: sl(),
      networkInfo: sl()));
  //External
  sl.registerLazySingleton(() => AuthDao());
  sl.registerLazySingleton(() => MoviesDao());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
