part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class CheckAuthEvent extends AuthEvent {}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted({required this.username, required this.password});
  final String username;
  final String password;
}

class SignupSubmitted extends AuthEvent {
  const SignupSubmitted({
    required this.username,
    required this.fan,
    required this.password,
  });
  final String username;
  final String fan;
  final String password;
}

class LogoutRequested extends AuthEvent {}


