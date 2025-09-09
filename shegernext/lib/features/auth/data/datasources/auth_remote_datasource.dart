import 'package:dio/dio.dart';
import 'package:shegernext/core/config/end_points.dart';
import 'package:shegernext/core/error/exception.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/auth/data/datasources/auth_local_datasource.dart';

abstract class AuthRemoteDataSource {
  Future<String> login({required String username, required String password});
  Future<void> signup({
    required String username,
    required String fan,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthLocalDataSource localDataSource;
  AuthRemoteDataSourceImpl({required Dio client, required this.localDataSource})
    : _client = client..options.baseUrl = EndPoints.baseUrl;
  final Dio _client;

  @override
  Future<String> login({
    required String username,
    required String password,
  }) async {
    final Response<dynamic> response = await _client.post(
      EndPoints.login,
      data: <String, dynamic>{'username': username, 'password': password},
    );
    final token = response.data['token'];
    localDataSource.storeToken(token: token);
    return token;
  }

  @override
  Future<void> signup({
    required String username,
    required String fan,
    required String password,
  }) async {
    final Response<dynamic> response = await _client.post(
      EndPoints.singUp,
      data: <String, dynamic>{
        'username': username,
        'fan': fan,
        'password': password,
      },
    );
    if (response.statusCode != 201) {
      throw ServerException(message: 'Error signing up');
    }
  }
}
