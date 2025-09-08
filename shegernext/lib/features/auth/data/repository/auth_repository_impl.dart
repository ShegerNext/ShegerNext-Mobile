import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:shegernext/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthRemoteDataSource remote}) : _remote = remote;

  final AuthRemoteDataSource _remote;

  @override
  Future<Either<Failures, String>> login({
    required String username,
    required String password,
  }) async {
    try {
      final String token = await _remote.login(
        username: username,
        password: password,
      );
      return Right(token);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> signup({
    required String username,
    required String fan,
    required String password,
  }) async {
    try {
      final String token = await _remote.signup(
        username: username,
        fan: fan,
        password: password,
      );
      return Right(token);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}


