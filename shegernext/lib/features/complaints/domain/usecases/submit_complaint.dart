import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/complaints/domain/repository/complaints_repository.dart';

class SubmitComplaint {
  SubmitComplaint({required ComplaintsRepository repository})
    : _repository = repository;

  final ComplaintsRepository _repository;

  Future<Either<Failures, Complaint>> call(Complaint complaint) {
    return _repository.submitComplaint(complaint);
  }
}
