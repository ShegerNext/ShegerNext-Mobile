import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shegernext/features/auth/domain/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required Login login,
    required Signup signup,
    required FlutterSecureStorage storage,
  }) : _login = login,
       _signup = signup,
       _storage = storage,
       super(AuthInitial()) {
    on<CheckAuthEvent>(_onCheck);
    on<LoginSubmitted>(_onLogin);
    on<SignupSubmitted>(_onSignup);
    on<LogoutRequested>(_onLogout);
  }

  final Login _login;
  final Signup _signup;
  final FlutterSecureStorage _storage;

  Future<void> _onCheck(CheckAuthEvent event, Emitter<AuthState> emit) async {
    final String? token = await _storage.read(key: 'access_token');
    if (token != null && token.isNotEmpty) {
      emit(Authenticated(token));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogin(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _login(
      username: event.username,
      password: event.password,
    );
    result.fold((l) => emit(AuthError(l.message)), (token) async {
      await _storage.write(key: 'access_token', value: token);
      emit(Authenticated(token));
    });
  }

  Future<void> _onSignup(SignupSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _signup(
      username: event.username,
      fan: event.fan,
      password: event.password,
    );
    result.fold((l) => emit(AuthError(l.message)), (token) async {
      emit(AuthLoading());
    });
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    await _storage.delete(key: 'access_token');
    emit(Unauthenticated());
  }
}


