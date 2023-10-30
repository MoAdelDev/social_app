part of 'likes_bloc.dart';

abstract class BaseLikesEvent {
  const BaseLikesEvent();
}

class LikesGetUsersEvent extends BaseLikesEvent {
  final String postId;

  const LikesGetUsersEvent(this.postId);
}
