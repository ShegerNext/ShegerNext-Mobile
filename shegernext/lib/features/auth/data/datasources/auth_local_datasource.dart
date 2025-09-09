import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shegernext/core/config/end_points.dart';

abstract class AuthLocalDataSource {
  Future<void> storeToken({required String token});
  Future<String> getToken();
  Future<void> deleteToken();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> deleteToken() async {
    await storage.delete(key: EndPoints.accessTokenKey);
  }

  @override
  Future<String> getToken() async {
    return (await storage.read(key: EndPoints.accessTokenKey))!;
  }

  @override
  Future<void> storeToken({required String token}) async {
    await storage.write(key: EndPoints.accessTokenKey, value: token);
  }

  Future<bool> isAuthenticated() async {
    return await storage.read(key: EndPoints.accessTokenKey) != null;
  }
}
