part of 'user_posts_bloc.dart';

sealed class UserPostsState extends Equatable {
  const UserPostsState();
  @override
  List<Object?> get props => [];
}

class UserPostsInitial extends UserPostsState {}

class UserPostsLoading extends UserPostsState {}

class UserPostsLoaded extends UserPostsState {
  const UserPostsLoaded(this.complaints);
  final List<Complaint> complaints;
  @override
  List<Object?> get props => [complaints];
}

class UserPostsError extends UserPostsState {
  const UserPostsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
