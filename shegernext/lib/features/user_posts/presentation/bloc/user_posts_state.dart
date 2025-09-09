part of 'user_posts_bloc.dart';

abstract class UserPostsState extends Equatable {
  const UserPostsState();
  @override
  List<Object?> get props => [];
}

class UserPostsInitial extends UserPostsState {}

class UserPostsLoading extends UserPostsState {}

class UserPostsLoaded extends UserPostsState {
  final List<Complaint> complaints;
  const UserPostsLoaded(this.complaints);

  @override
  List<Object?> get props => [complaints];
}

class UserPostsError extends UserPostsState {
  final String message;
  const UserPostsError(this.message);

  @override
  List<Object?> get props => [message];
}