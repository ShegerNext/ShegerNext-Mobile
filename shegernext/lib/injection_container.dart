import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shegernext/core/network/network_info.dart';
import 'package:shegernext/features/complaints/data/datasources/complaints_remote_datasource.dart';
import 'package:shegernext/features/complaints/data/repository/complaints_repository_impl.dart';
import 'package:shegernext/features/complaints/domain/repository/complaints_repository.dart';
import 'package:shegernext/features/complaints/domain/usecases/submit_complaint.dart';
import 'package:shegernext/features/complaints/presentation/bloc/complaints_bloc.dart';
import 'package:shegernext/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:shegernext/features/auth/data/repository/auth_repository_impl.dart';
import 'package:shegernext/features/auth/domain/repository/auth_repository.dart';
import 'package:shegernext/features/auth/domain/usecases/auth_usecases.dart';
import 'package:shegernext/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shegernext/features/user_posts/data/datasources/user_posts_remote_datasource.dart';
import 'package:shegernext/features/user_posts/data/repository/user_posts_repository_impl.dart';
import 'package:shegernext/features/user_posts/domain/repository/user_posts_repository.dart';
import 'package:shegernext/features/user_posts/domain/usecases/get_user_posts.dart';
import 'package:shegernext/features/user_posts/presentation/bloc/user_posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(internetConnectionChecker: sl()),
  );

  //! External
  sl.registerLazySingleton(() => FlutterSecureStorage());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton(() => Dio());

  //? Features
  // Complaints
  sl.registerLazySingleton<ComplaintsRemoteDataSource>(
    () => ComplaintsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ComplaintsRepository>(
    () => ComplaintsRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton(() => SubmitComplaint(repository: sl()));
  sl.registerFactory(() => ComplaintsBloc(submitComplaint: sl()));

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton(() => Login(repository: sl()));
  sl.registerLazySingleton(() => Signup(repository: sl()));
  sl.registerFactory(() => AuthBloc(login: sl(), signup: sl(), storage: sl()));

  // User Posts
  sl.registerLazySingleton<UserPostsRemoteDataSource>(
    () => UserPostsRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<UserPostsRepository>(
    () => UserPostsRepositoryImpl(remote: sl()),
  );
  sl.registerLazySingleton(() => GetUserPosts(repository: sl()));
  sl.registerFactory(() => UserPostsBloc(getUserPosts: sl(), storage: sl()));
}
