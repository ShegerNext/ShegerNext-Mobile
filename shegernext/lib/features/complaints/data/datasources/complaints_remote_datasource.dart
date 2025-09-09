import 'package:dio/dio.dart';
import 'package:shegernext/core/config/end_points.dart';
import 'package:shegernext/features/complaints/data/models/complaint_model.dart';

abstract class ComplaintsRemoteDataSource {
  Future<ComplaintModel> submitComplaint(ComplaintModel complaint, String accessToken);
}

class ComplaintsRemoteDataSourceImpl implements ComplaintsRemoteDataSource {
  ComplaintsRemoteDataSourceImpl({required Dio client}) : _client = client;

  final Dio _client;

  @override
  Future<ComplaintModel> submitComplaint(ComplaintModel complaint, String accessToken) async {
    final Response<dynamic> response = await _client.post(
      '/complaints',
      data: complaint.toRequestJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );
    return ComplaintModel.fromResponseJson(
      response.data as Map<String, dynamic>,
    );
  }
}
