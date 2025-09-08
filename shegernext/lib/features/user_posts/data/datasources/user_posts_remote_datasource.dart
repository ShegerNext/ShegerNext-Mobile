import 'package:dio/dio.dart';
import 'package:shegernext/core/config/end_points.dart';
import 'package:shegernext/features/complaints/data/models/complaint_model.dart';

abstract class UserPostsRemoteDataSource {
  Future<List<ComplaintModel>> getUserPosts({required String accessToken});
}

class UserPostsRemoteDataSourceImpl implements UserPostsRemoteDataSource {
  UserPostsRemoteDataSourceImpl({required Dio client})
    : _client = client..options.baseUrl = EndPoints.baseUrl;
  final Dio _client;

  @override
  Future<List<ComplaintModel>> getUserPosts({
    required String accessToken,
  }) async {
    // First get user info using access token
    final Response<dynamic> userResponse = await _client.get(
      '/user/profile',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    final String userId =
        (userResponse.data as Map<String, dynamic>)['id'] as String;

    // Then get user posts using user ID and access token
    final Response<dynamic> postsResponse = await _client.get(
      '/user/$userId/complaints',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );

    final List<dynamic> postsData = postsResponse.data as List<dynamic>;
    return postsData
        .map(
          (json) =>
              ComplaintModel.fromResponseJson(json as Map<String, dynamic>),
        )
        .toList();
  }
}
