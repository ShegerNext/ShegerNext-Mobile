import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/complaints/data/datasources/complaints_remote_datasource.dart';
import 'package:shegernext/features/complaints/data/models/complaint_model.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/complaints/domain/repository/complaints_repository.dart';

class ComplaintsRepositoryImpl implements ComplaintsRepository {
  ComplaintsRepositoryImpl({required ComplaintsRemoteDataSource remote})
    : _remote = remote;

  final ComplaintsRemoteDataSource _remote;

  @override
  Future<Either<Failures, Complaint>> submitComplaint(
    Complaint complaint,
    String accessToken,
  ) async {
    try {
      final ComplaintModel model = ComplaintModel(
        id: complaint.id,
        text: complaint.text,
        clerkUserId: complaint.clerkUserId,
        category: complaint.category,
        latitude: complaint.latitude,
        longitude: complaint.longitude,
        imageUrl: complaint.imageUrl,
        priority: complaint.priority,
        status: complaint.status,
        createdAt: complaint.createdAt,
      );
      final ComplaintModel response = await _remote.submitComplaint(model, accessToken);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
