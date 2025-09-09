import 'package:dio/dio.dart';
import 'package:shegernext/core/config/end_points.dart';
import 'package:shegernext/features/complaints/data/models/complaint_model.dart';

abstract class UserPostsRemoteDataSource {
  Future<List<ComplaintModel>> getUserPosts({required String accessToken});
}

class UserPostsRemoteDataSourceImpl implements UserPostsRemoteDataSource {
  final Dio client;
  UserPostsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ComplaintModel>> getUserPosts({
    required String accessToken,
  }) async {
    client.options.baseUrl = EndPoints.baseUrl;
    final Response<dynamic> postsResponse = await client.get(
      EndPoints.userPosts,
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
