import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';

abstract class ComplaintsRepository {
  Future<Either<Failures, Complaint>> submitComplaint(Complaint complaint);
}
