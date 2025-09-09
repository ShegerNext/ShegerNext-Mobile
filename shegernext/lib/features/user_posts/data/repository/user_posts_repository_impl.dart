import 'package:dartz/dartz.dart';
import 'package:shegernext/core/error/failures.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/complaints/data/models/complaint_model.dart';
import 'package:shegernext/features/user_posts/data/datasources/user_posts_remote_datasource.dart';
import 'package:shegernext/features/user_posts/domain/repository/user_posts_repository.dart';

class UserPostsRepositoryImpl implements UserPostsRepository {
  UserPostsRepositoryImpl({required UserPostsRemoteDataSource remote})
    : _remote = remote;

  final UserPostsRemoteDataSource _remote;

  @override
  Future<Either<Failures, List<Complaint>>> getUserPosts({
    required String accessToken,
  }) async {
    try {
      final List<ComplaintModel> models = await _remote.getUserPosts(
        accessToken: accessToken,
      );
      final List<Complaint> complaints = models;
      return Right(complaints);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
