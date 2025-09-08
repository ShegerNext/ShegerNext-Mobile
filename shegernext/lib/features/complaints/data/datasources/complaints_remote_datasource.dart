import 'package:dio/dio.dart';
import 'package:shegernext/core/config/end_points.dart';
import 'package:shegernext/features/complaints/data/models/complaint_model.dart';

abstract class ComplaintsRemoteDataSource {
  Future<ComplaintModel> submitComplaint(ComplaintModel complaint);
}

class ComplaintsRemoteDataSourceImpl implements ComplaintsRemoteDataSource {
  ComplaintsRemoteDataSourceImpl({required Dio client});

  final Dio _client = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  @override
  Future<ComplaintModel> submitComplaint(ComplaintModel complaint) async {
    final Response<dynamic> response = await _client.post(
      '/complaints',
      data: complaint.toRequestJson(),
    );
    return ComplaintModel.fromResponseJson(
      response.data as Map<String, dynamic>,
    );
  }
}
