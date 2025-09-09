import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shegernext/features/complaints/domain/entity/complaint.dart';
import 'package:shegernext/features/user_posts/domain/usecases/get_user_posts.dart';

part 'user_posts_event.dart';
part 'user_posts_state.dart';

class UserPostsBloc extends Bloc<UserPostsEvent, UserPostsState> {
  UserPostsBloc({
    required GetUserPosts getUserPosts,
    required FlutterSecureStorage storage,
  })  : _getUserPosts = getUserPosts,
        _storage = storage,
        super(UserPostsInitial()) {
    on<LoadUserPostsEvent>(_onLoadUserPosts);
  }

  final GetUserPosts _getUserPosts;
  final FlutterSecureStorage _storage;

  Future<void> _onLoadUserPosts(
    LoadUserPostsEvent event,
    Emitter<UserPostsState> emit,
  ) async {
    emit(UserPostsLoading());

    final String? token = await _storage.read(key: 'access_token');
    if (token == null || token.isEmpty) {
      emit(UserPostsError('No access token found'));
      return;
    }

    final result = await _getUserPosts(accessToken: token);
    result.fold(
      (l) => emit(UserPostsError(l.message)),
      (r) => emit(UserPostsLoaded(r)),
    );
  }
}