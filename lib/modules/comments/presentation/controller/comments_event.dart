part of 'comments_bloc.dart';

abstract class BaseCommentsEvent {
  const BaseCommentsEvent();
}

class CommentsAddEvent extends BaseCommentsEvent {
  final String postId;
  final String commentText;

  const CommentsAddEvent(
    this.postId,
    this.commentText,
  );
}

class CommentsGetEvent extends BaseCommentsEvent {
  final String postId;

  const CommentsGetEvent(
    this.postId,
  );
}
