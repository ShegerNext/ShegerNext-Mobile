import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/user_posts/domain/repository/user_posts_repository.dart';

class GetUserPosts {
  GetUserPosts({required UserPostsRepository repository})
    : _repository = repository;

  final UserPostsRepository _repository;

  Future<Either<Failures, List<Complaint>>> call({
    required String accessToken,
  }) {
    return _repository.getUserPosts(accessToken: accessToken);
  }
}
