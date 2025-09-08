import 'package:dio/dio.dart';
import 'package:shegernext/core/config/end_points.dart';

abstract class AuthRemoteDataSource {
  Future<String> login({required String username, required String password});
  Future<String> signup({
    required String username,
    required String fan,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required Dio client})
    : _client = client..options.baseUrl = EndPoints.baseUrl;
  final Dio _client;

  @override
  Future<String> login({
    required String username,
    required String password,
  }) async {
    final Response<dynamic> response = await _client.post(
      '/auth/login',
      data: <String, dynamic>{'username': username, 'password': password},
    );
    return (response.data as Map<String, dynamic>)['token'] as String;
  }

  @override
  Future<String> signup({
    required String username,
    required String fan,
    required String password,
  }) async {
    final Response<dynamic> response = await _client.post(
      '/auth/signup',
      data: <String, dynamic>{
        'username': username,
        'fan': fan,
        'password': password,
      },
    );
    return (response.data as Map<String, dynamic>)['token'] as String;
  }
}
