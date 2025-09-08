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
}
