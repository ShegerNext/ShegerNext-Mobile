part of 'user_posts_bloc.dart';

sealed class UserPostsEvent extends Equatable {
  const UserPostsEvent();
  @override
  List<Object?> get props => [];
}

class LoadUserPostsEvent extends UserPostsEvent {}
