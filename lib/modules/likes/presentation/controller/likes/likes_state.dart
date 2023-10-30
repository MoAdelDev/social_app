part of 'likes_bloc.dart';

class LikesState extends Equatable {
  final List<User> users;
  final RequestState likesState;
  final String likesError;

  const LikesState({
    this.users = const [],
    this.likesState = RequestState.loading,
    this.likesError = '',
  });

  LikesState copyWith({
    List<User>? users,
    RequestState? likesState,
    String? likesError,
  }) =>
      LikesState(
        users: users ?? this.users,
        likesState: likesState ?? this.likesState,
        likesError: likesError ?? this.likesError,
      );

  @override
  List<Object> get props => [
        users,
        likesState,
        likesError,
      ];
}
