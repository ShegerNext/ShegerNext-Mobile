import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/auth/domain/repository/auth_repository.dart';

class Login {
  Login({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;
  Future<Either<Failures, String>> call({
    required String username,
    required String password,
  }) => _repository.login(username: username, password: password);
}

class Signup {
  Signup({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;
  Future<Either<Failures, String>> call({
    required String username,
    required String fan,
    required String password,
  }) => _repository.signup(username: username, fan: fan, password: password);
}
