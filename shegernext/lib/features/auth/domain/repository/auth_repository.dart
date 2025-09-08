import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failures, String>> login({
    required String username,
    required String password,
  });
  Future<Either<Failures, String>> signup({
    required String username,
    required String fan,
    required String password,
  });
}


